require 'awesome_print'
require 'erb'
require 'yaml'
require 'travis/yml'

include Travis::Yml

AI = {
  indent:        -2,     # Number of spaces for indenting.
  index:         false,  # Display array indices.
  multiline:     false,  # Display in multiple lines.
  plain:         true,   # Use colors.
  ruby19_syntax: true,   # Use Ruby 1.9 hash syntax in output.
}

module Gen
  module Specs
    extend self

    def new(type, group)
      const_get(type.to_s.capitalize).new(group)
    end

    module Spec
      extend self

      module Helpers
        def root?
          parent.nil?
        end

        def root
          root? ? self : parent.root
        end

        def parent(const = nil)
          return super() unless const
          parent.is_a?(const) ? parent : parent.parent(const)
        end

        def indent(str)
          str.to_s.split("\n").map { |str| ' ' * 2 + str }.join("\n")
        end

        def wrap(keys, obj)
          obj = keys.reverse.inject(obj) { |obj, key| { key => obj } }
          obj = { provider: root.id.to_s }.merge(obj) if root.key == :deploy
          obj
        end

        def wrap(keys, obj)
          keys = keys.reverse
          key = keys.shift
          obj = { key => obj }
          obj = { provider: root.id.to_s }.merge(obj) if root.key == :deploy
          obj = keys.inject(obj) { |obj, key| { key => obj } }
          obj
        end

        def stringify(obj)
          case obj
          when ::Array then obj.map { |obj| stringify(obj) }
          when ::Hash  then obj.map { |key, obj| [key.to_s, stringify(obj)] }.to_h
          else obj
          end
        end

        def camelize(str)
          str.to_s.split('_').collect(&:capitalize).join
        end

        def ai(obj)
          str = obj.ai(AI)
          str = str.gsub(/ +:/, ':')
          str = str.gsub('::', ': :')
          str = str.gsub(/(^{ | }$)/, '')
          str = str.gsub(/(\[ | \])/) { $1.strip }
          str = str.gsub('"', "'")
          str
        end
      end

      SAMPLES = {
        bool: true,
        num: 1,
        str: 'str',
        enum: 'str',
        secure: { secure: 'secure' }
      }

      module Example
        class It < Struct.new(:keys, :expected)
          include Helpers
        end

        class Serializes < It
          def render
            "it { should serialize_to #{ai expected} }"
          end

          # def expected
          #   wrap(keys, super)
          # end
        end

        class NoMsg < It
          def render
            "it { should_not have_msg }"
          end
        end

        class Node < Struct.new(:parent, :key, :type, :expectations)
          include Helpers

          def parent(const = nil)
            return super() unless const
            parent.is_a?(const) ? parent : parent.parent(const)
          end

          def children
            []
          end

          def render
            lines = ["describe '#{title}' do"]
            lines << indent(yaml)
            lines << indent(expectations.map(&:render).join("\n"))
            lines << "end\n"
            lines.join("\n")
          end

          def yaml
            yaml = YAML.dump(stringify(input))
            yaml = yaml.sub(/---/, '').sub('...', '').strip
            "yaml %(\n#{indent(yaml)}\n)"
          end

          def keys
            parent.keys
          end

          def sample(type)
            SAMPLES[type]
          end
        end

        class Scalar < Node
          def title
            "given a #{type}"
          end

          def input
            wrap(keys, sample(type))
          end
        end

        Bool = Class.new(Scalar)
        Num  = Class.new(Scalar)
        Str  = Class.new(Scalar)
        Enum = Class.new(Scalar)
        Secure = Class.new(Scalar)

        class Seq < Node
          def title
            "given a seq of #{type}s"
          end

          def input
            wrap(keys, [sample(type)])
          end
        end
      end

      class Node < Struct.new(:parent, :key, :schema)
        include Helpers

        def id
          schema.id
        end

        def keys
          root? ? [] : [*parent.keys, key].uniq
        end

        def build(schema, parent = self)
          name = schema.type.to_s.capitalize
          Spec.const_get(name).new(parent, key, schema)
        end

        def example(type, expectations)
          type, child = *type
          const = Example.const_get(type.to_s.capitalize)
          node = const.new(self, key, child || type)
          node.expectations = expectations
          node
        end

        def expect(type, *args)
          Example.const_get(camelize(type.to_s)).new(*args)
        end

        def type
          self.class.name.split('::').last.downcase.to_sym
        end

        def sample(type)
          SAMPLES[type]
        end
      end

      class Group < Node
        def render
          children.map(&:render).join("\n")
        end
      end

      class Describe < Node
        def render
          lines = ["describe '#{title}' do"]
          lines << indent(body)
          lines << "end\n"
          lines.join("\n")
        end

        def body
          examples.map(&:render).join("\n")
        end
      end

      class Scalar < Node
        def render
          example(type, [Example::Serializes.new(keys, expected)]).render
        end

        def expected
          wrap(keys, sample(type))
        end
      end

      Bool = Class.new(Scalar)
      Num  = Class.new(Scalar)
      Str  = Class.new(Scalar)
      Secure = Class.new(Scalar)

      class Enum < Scalar
        def sample(type)
          super
        end
      end

      class Any < Group
        def children
          child = build(schema.schemas.first)
          child.is_a?(Any) ? [child.children.first] : [child]
        end

        # def keys
        #   parent.keys
        # end
      end

      class Seq < Node
        def children
          child = build(schema.schema)
          children = child.is_a?(Any) ? child.children : [child]
          children.map { |child| build(child.schema) }
        end

        def render
          examples = children.map(&method(:examples)).flatten
          examples.map(&:render).join("\n")
        end

        def examples(child)
          expects = [expect(:serializes, keys, expected), expect(:no_msg)]
          [example([:seq, child.type], expects), example(child.type, expects)]
        end

        def expected
          wrap(keys, [sample(children.first.type)])
        end
      end

      class Map < Group
        def children
          schema.map.map do |key, schema|
            Mapping.new(self, key, schema)
          end.flatten
        end
      end

      class Mapping < Describe
        def children
          child = build(schema)
          children = child.is_a?(Any) ? child.children : [child]
          children.map { |child| build(child.schema) }
        end

        def title
          key
        end

        def body
          children.map(&:render).join("\n")
        end

        # def keys
        #   parent.keys
        # end
      end

      class Subject < Node
        def render
          "subject { described_class.apply(parse(yaml)) }\n"
        end
      end

      class Accept < Node
        PATH = 'spec/travis/yml/accept'

        def render
          lines = ["describe Travis::Yml, '#{id}' do"]
          lines << indent(children.map(&:render).join("\n"))
          lines << "end\n"
          lines.join("\n")
        end

        def children
          [Subject.new(self)] + [build(schema, nil)]
        end

        def write
          spec = render
          File.write(path, spec)
          spec
        end

        def path
          "#{[PATH, key == :language ? :lang : key, id].join('/')}_spec.rb"
        end
      end
    end

    class Specs < Struct.new(:group)
      def write
        specs.map(&:write)
      end

      def render
        # [specs.first.render]
        specs[0, 1].map(&:render).map { |s| s.split("\n")[0..50].join("\n") }
        # specs.map(&:render)
      end

      def schemas
        Travis::Yml.schema[:definitions][group].values.reject do |lang|
          lang[:'$id'].to_s.include?('__')
        end
      end
    end

    class Accept < Specs
      def specs
        schemas.map { |schema| Spec::Accept.new(nil, group, expand(schema)) }
      end

      def expand(schema)
        defs = Travis::Yml.schema[:definitions]
        schema = Doc::Schema.expand(schema, defs)
        Doc::Schema.build(schema)
      end
    end
  end
end
