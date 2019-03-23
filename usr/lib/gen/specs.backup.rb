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

      YML = {
        boolean: :bool,
        number: :num,
        string: :str,
        object: :map,
        array: :seq,
      }

      class Node < Struct.new(:parent, :key, :schema)
        def id
          schema.id
        end

        def build(parent, schema)
          name = schema.type.to_s.capitalize
          Spec.const_get(name).new(parent, key, schema)
        end

        def const
          name = schema[:anyOf] ? :any : schema[:type]
          Spec.const_get(name.to_s.capitalize)
        end

        def root?
          parent.nil?
        end

        def parent(const = nil)
          return super() if const.nil?
          raise "no parent #{const}" if root?
          parent.is_a?(const) ? parent : parent.parent(const)
        end

        def keys
          root? ? [] : [*parent.keys, key]
        end

        def indent(str)
          str.to_s.split("\n").map { |str| ' ' * 2 + str }.join("\n")
        end

        # def schemas(schema = self.schema)
        #   # return schema.map { |schema| schemas(schema) }.flatten if schema.is_a?(::Array)
        #   return schema[:anyOf].map { |schema| schemas(schema) }.flatten if schema[:anyOf]
        #   return schemas(resolve(schema)).flatten if schema.key?(:'$ref')
        #   [schema]
        # end

        # def resolve(schema)
        #   schema.key?(:'$ref') ? definition(schema[:'$ref']) : schema
        # end

        def definition(ref)
          keys = ref.to_s.sub('#/definitions/', '').split('/').map(&:to_sym)
          definition = keys.inject(definitions) { |defs, key| defs[key] || unknown(ref) }
          definition || unknown(ref)
        end

        def definitions
          Travis::Yml.schema[:definitions]
        end

        def wrap(obj)
          keys.reverse.inject(obj) { |obj, key| { key => obj } }
        end

        def stringify(obj)
          case obj
          when ::Array then obj.map { |obj| stringify(obj) }
          when ::Hash  then obj.map { |key, obj| [key.to_s, stringify(obj)] }.to_h
          else obj
          end
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

      class Group < Node
        def render
          children.map(&:render).join("\n")
        end
      end

      class Describe < Node
        def render
          lines = ["describe '#{title}' do"]
          lines << indent(children.map(&:render).join("\n"))
          lines << "end\n"
          lines.join("\n")
        end
      end

      class Yaml < Node
        def render
          "yaml %(\n#{indent(yaml)}\n)"
        end

        def yaml
          yaml = YAML.dump(stringify(parent.data))
          yaml = yaml.sub(/---/, '').sub('...', '').strip
        end

        def keys
          parent.keys
        end
      end

      class It < Node
        def render
          "it { should serialize_to #{ai expected} }"
        end

        def expected
          wrap(parent(Mapping).expected)
        end

        def keys
          parent.keys
        end
      end

      SAMPLES = {
        bool: true,
        num: 1,
        str: 'str'
      }

      class Example < Describe
        def children
          [Yaml.new(self, key, schema), It.new(self, key, schema)]
        end

        def title
          "given a #{type}"
        end

        def type
          schema.type
        end

        def data
          wrap(SAMPLES[type])
        end
      end

      class Seq < Example
        def title
          "given a seq of #{schema.schema.type}s"
        end

        def children
        end

        def type
          schema.schema.class
          # items = schema[:items]
          # items = items[:anyOf][0] if items.key?(:anyOf)
          # items[:type]
        end

        def data
          p type
          wrap([SAMPLES[type].to_s])
        end
      end

      class Bool < Example
      end

      class Num < Example
      end

      class Str < Example
      end

      class Any < Group
        def children
          normal = schema.schemas.select(&:normal?).first
          build(parent, normal || schema.schemas.first)
        end
      end

      class Mapping < Describe
        def children
          [build(self, schema)]
        end

        def title
          key
        end

        def expected
          case schema.type
          when :seq
            # [SAMPLES[schemas(schema[:items])[0][:type]]]
            fail
            [SAMPLES[schema.schema.type]]
          else
            SAMPLES[schema.type]
          end
        end

        def type
          if schema[:anyOf]
            schema[:anyOf][0][:type]
          else
            schema[:type]
          end
        end

        def keys
          parent.keys
        end
      end

      class Map < Group
        def children
          schema.map.map do |key, schema|
            Mapping.new(self, key, schema)
          end.flatten
        end
      end

      class Subject < Node
        def render
          "subject { described_class.apply(parse(yaml)) }\n"
        end
      end

      class Accept < Map
        PATH = 'spec/travis/yml/accept'

        def render
          lines = ["describe Travis::Yml, '#{id}' do"]
          lines << indent(children.map(&:render).join("\n"))
          lines << "end\n"
          lines.join("\n")
        end

        def children
          [Subject.new(self)] + super
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
        [specs.first.render]
        # specs[0, 6].map(&:render)
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
