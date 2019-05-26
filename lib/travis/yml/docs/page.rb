require 'forwardable'
require 'yaml'
require 'travis/yml/schema'

module Travis
  module Yml
    module Docs
      module Page
        extend self

        def build(schema)
          const_get(schema.class.name.split('::').last).new(schema)
        end

        module Rendering
          def render(name = nil, opts = {})
            name ||= self.class.name.split('::').last.downcase
            scope = binding
            opts.each { |key, value| scope.local_variable_set(key, value) }
            ERB.new(tpl(name), nil, '-').result(scope)
          end

          def tpl(name)
            File.read(File.expand_path("../tpl/#{name}.erb.md", __FILE__))
          end
        end

        class Index < Obj.new(:pages, :current)
          include Helper::Obj, Rendering

          def pages
            pages = super.values
            root  = pages.detect(&:root?)
            pages = pages - [root]
            groups = pages.group_by(&:namespace)
            pages = [root, *groups[:type]]
            pages = pages.map(&:id).zip(pages).to_h
            groups = except(groups, :type)
            curr = pages[current.to_sym]
            curr.children = groups[current.sub(/s$/, '').to_sym] if curr
            pages.values
          end

          def active?(page)
            page.path =~ /#{current.split('/').first}s?$/
          end
        end

        class Base < Obj.new(:node)
          extend Forwardable
          include Rendering

          def_delegators :node, :namespace, :id, :root?, :aliases, :deprecated,
            :deprecated?, :enum, :flags, :internal?, :summary

          attr_accessor :children

          BASE_TYPES = %i(strs secure secures)

          def full_id
            [namespace != :type ? namespace : nil, id].compact.join('/') if id
          end

          def path
            "/v1/docs/#{full_id}" if full_id && !base_type?
          end

          def parents
            node.parents.map do |schema|
              schema = schema.parents.first if schema.id == :job
              build(schema)
            end.uniq(&:id)
          end

          def parent_id
            return id if root?
            parent = parents.detect(&:id)
            return parent.id if parent
            parents.map(&:parent_id).first
          end

          def info
            info = []
            info << 'deprecated' if deprecated?
            info << "alias: #{aliases.map { |name| "`#{name}`" }.join(', ')}" if aliases
            info << "known values: #{enum.map { |value| "`#{value}`" }.join(', ')}" if enum
            info = "(#{info.join(', ')})" if info.any?
            info = [summary, info].flatten.compact
            info << "[details](#{path})" if path
            info.join(' ') if info.any?
          end

          def title
            id == :root ? 'Root' : node.title
          end

          def description
            join(node.description) if node.description
          end

          def examples
            []
          end

          DISPLAY_TYPES = {
            seq: 'Sequence of %s',
            map: 'Map',
            str: 'String',
            num: 'Number',
            bool: 'Boolean',
            secure: 'Secure'
          }

          def display_type
            publish? ? "[#{title}](#{path})": DISPLAY_TYPES[node.type]
          end

          def pages
            [self].select(&:publish?)
          end

          def publish?
            id && !internal? && !base_type?
          end

          def singular?
            # parents.any? { |parent| parent.id == "#{id}s".to_sym }
            false
          end

          def base_type?
            BASE_TYPES.include?(id)
          end

          def build(schema)
            Page.build(schema)
          end

          def join(str)
            str.split("\n\n").map { |str| str.lines.map(&:chomp).join(' ') }.join("\n\n")
          end

          def indent(str, width)
            strs = str.split("\n")
            [strs.shift, strs.map { |str| (' ' * width * 2) + str }].join("\n")
          end

          def yaml(obj)
            obj = stringify(obj)
            yml = YAML.dump(obj)
            yml = yml.sub(/^--- ?/, '')
            yml = yml.sub("...\n", '')
            yml = yml.sub("'on'", 'on')
            yml.strip
          end

          # def walk(obj = nil, &block)
          #   yield *[obj].compact, self if id && !internal?
          #   obj
          # end

          def hash
            id.hash
          end

          def ==(other)
            id == other.id
          end

          def inspect
            'page'
          end
        end

        class Any < Base
          def pages
            pages = node.schemas.map { |node| build(node).pages }.flatten
            [self, *pages].select(&:publish?)
          end

          def types
            node.schemas.map(&:types).flatten
          end

          def display_types
            types.map { |node| build(node).display_type }
          end

          def enum
            node = types.detect { |schema| schema.type == :str }
            node.enum if node
          end

          def mappings
            return unless node = types.detect { |schema| schema.type == :map }
            node.mappings.map { |key, schema| [key, build(schema)] }.to_h
          end

          def examples
            Yml::Schema::Examples.build(node).examples.map do |example|
              # key = node.key || node.namespace
              node.key ? { node.key => example } : example
            end
          end
        end

        class Seq < Base
          def pages
            [self, *build(node.schema).pages].flatten.select(&:publish?)
          end

          def display_type
            child = build(node.schema)
            type = child.publish? ? "[#{child.title}](#{child.path})" : DISPLAY_TYPES[child.node.type]
            DISPLAY_TYPES[:seq] % type
          end
        end

        class Map < Base
          include Enumerable

          def_delegators :mappings, :each, :[]

          attr_reader :includes, :mappings

          def initialize(node)
            @mappings = node.map { |key, schema| [key, build(schema)] }.to_h
            @includes = node.includes.map { |schema| build(schema) }
            super
          end

          def render(name = :map, opts = {})
            super
          end

          def pages
            # p includes.first.mappings[:group].class if includes.any?
            # p includes.first.pages.map(&:id).sort.uniq if includes.any?
            # p includes.map(&:pages).flatten.map(&:id).uniq.sort if includes.any?
            [self, *includes.map(&:pages), *mappings.values.map(&:pages)].flatten
          end

          # def walk(obj = nil, &block)
          #   yield *[obj].compact, self
          #   mappings.each { |_, page| page.walk(*[obj].compact, &block) }
          #   obj
          # end
        end

        class Secure < Base
        end

        class Scalar < Base
        end
      end
    end
  end
end
