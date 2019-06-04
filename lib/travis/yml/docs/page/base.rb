require 'forwardable'
require 'travis/yml/docs/page/render'

module Travis
  module Yml
    module Docs
      module Page
        class Base < Obj.new(:node)
          extend Forwardable
          include Render

          def_delegators :node, :namespace, :id, :root?, :aliases, :deprecated,
            :deprecated?, :enum, :examples, :flags, :internal?, :summary

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
      end
    end
  end
end
