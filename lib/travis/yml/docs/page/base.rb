require 'forwardable'
require 'travis/yml/docs/page/render'

module Travis
  module Yml
    module Docs
      module Page
        class << self
          def known_on
            @known_on ||= Hash.new { |hash, key| hash[key] = {} }
          end
        end

        class Base < Obj.new(:parent, :key, :node, :opts)
          extend Forwardable
          include Render

          def_delegators :node, :namespace, :id, :root?, :aliases, :deprecated,
            :deprecated?, :defaults, :enum, :example, :examples, :flags,
            :internal?, :prefix, :see, :summary, :any?, :seq?, :strs?, :type

          BASE_TYPES = %i(strs secure secures)
          JSON_TYPES = %i(bool num str)

          DISPLAY_TYPES = {
            strs: 'Sequence of Strings, or String',
            seq: 'Sequence of %s',
            map: 'Map',
            str: 'String',
            num: 'Number',
            bool: 'Boolean',
            enum: 'Enum (%s)',
            secure: 'Secure'
          }

          def initialize(parent, *)
            super
            return unless node = parent
            node = node.parent if node.included? || node.parent&.type == :any
            known_on[node.id] ||= node if node&.id
          end

          def known_on
            Page.known_on[id]
          end

          def root
            parent? ? parent.root : self
          end

          def mappings
            {}
          end

          def included?
            node&.included?
          end

          def display_types
            [display_type]
          end

          def display_type
            if strs?
              [DISPLAY_TYPES[:strs], path_to('types')]
            elsif publish? && !scalar?
              [title, path]
            elsif scalar? && enum
              [DISPLAY_TYPES[:enum] % DISPLAY_TYPES[node.type], path_to('types')]
            else
              [DISPLAY_TYPES[node.type], path_to('types')]
            end
          end

          def full_id
            ids.join('/')
          end

          def ids
            return ['nodes'] if root?
            ids = [key, id].uniq
            ids = ids[0, 1] if "#{ids[0]}s".to_sym == ids[1]
            [parent.ids, ids].flatten.compact
          end

          def path
            path_to(full_id) if publish?
          end

          def path_to(*segments)
            [opts[:path], *segments].flatten.join('/')
          end

          def info
            info = []
            info << '**deprecated**' if deprecated?
            info << "type: #{display_type.first.to_s.downcase}"
            info << "alias: #{aliases.map { |name| "`#{name}`" }.join(', ')}" if aliases
            info << "known values: #{trunc(enum).map { |value| "`#{value}`" }.join(', ')}" if enum
            info << "default: `#{default}`" if default
            info << "e.g.: `#{example}`" if example
            info << "[matrix expand key](#{opts[:path]}/matrix)" if flags.include?(:expand) && !details?
            info << "see: #{see.map { |str, url| "[#{str}](#{url})" }.join(', ')}" if see && !details?
            info = "(#{info.join(', ')})" if info.any?
            info = [summary, info].flatten.compact
            info << "[details](#{path})" if details?
            info.join(' ') if info.any?
          end

          def details?
            publish? && Docs.pages.keys.include?(path)
          end

          def title
            return 'Root' if root?
            publish? ? node.title : titleized_key
          end

          def menu_title
            titleize(key) || node.title
          end

          def title_with_key
            parts = []
            parts << title unless BASE_TYPES.include?(title&.downcase&.to_sym)
            parts << key if key && key != id.to_s.sub(/s$/, '').to_sym && key != title.downcase.to_sym && !title.downcase.include?(key.to_s)
            parts = parts.compact
            parts[1] = "(#{parts[1]})" if parts[1]
            parts[0] = titleize(parts[0])
            parts.join(' ')
          end

          def titleize(str)
            str.to_s.gsub('_', ' ').split(' ').map { |str| str[0].upcase + str[1..-1] }.join(' ') if str
          end

          def description
            join(node.description) if node.description
          end

          def default
            return unless defaults&.any?
            defaults.map { |value| value[:value] }.join(', ')
          end

          def trunc(enum)
            return unless enum
            enum = enum[0, 10] << '...' if enum.size > 10
            enum
          end

          def pages
            [self].select(&:publish?)
          end

          def children
            []
          end

          def publish?
            id && node && !internal? && !included? && !BASE_TYPES.include?(id)
          end

          def base_type?
            json_type? || BASE_TYPES.include?(id)
          end

          def json_type?
            id.nil? && JSON_TYPES.include?(type)
          end

          def scalar?
            is_a?(Scalar)
          end

          def static?
            false
          end

          def build(parent, key, node)
            Page.build(parent, key, node, opts)
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

          def inspect
            type = self.class.name.sub('Travis::Yml::Docs::', '')
            pairs = compact(id: id, type: type)
            '#<%s %s>' % [type, pairs.map { |pair| pair.join('=') }.join(' ')]
          end
        end
      end
    end
  end
end
