require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class Map < Group
          include Opts

          register :map

          opt_names %i(max_size prefix required strict)

          def type(*args)
            args.any? ? types(*args) : :map
          end

          def keys
            mappings.keys
          end

          def [](key)
            mappings[key]
          end

          def each(&block)
            mappings.each(&block)
          end

          def matrix(key, attrs = {})
            map(key, attrs.merge(expand: true))
          end

          def maps(*keys)
            attrs = keys.last.is_a?(Hash) ? keys.pop : {}
            keys.each { |key| map(key, attrs) }
          end

          # class Mapping < Node
          #   attr_reader :node
          #
          #   def initialize(node, attrs)
          #     @node = node
          #     node = build(node.type)
          #     remap(attrs).each { |key, value| node.send(key, value) }
          #     super(nil, node.attrs)
          #   end
          #
          #   def required?
          #     super || node.required?
          #   end
          #
          #   REMAP = {
          #     alias: :aliases,
          #     eg: :example,
          #     type: :types
          #   }
          #
          #   def remap(attrs)
          #     attrs.map { |key, obj| [REMAP[key] || key, obj] }.to_h
          #   end
          # end

          REMAP = {
            alias: :aliases,
            eg: :example,
            type: :types
          }

          def map(key, attrs = {})
            type = attrs[:to] || key
            attrs = { key: key }.merge(except(attrs, :to))
            attrs = attrs.map { |key, obj| [REMAP[key] || key, obj] }.to_h
            # mappings[key] = [type, Mapping.new(type, attrs).attrs]
            # mappings[key] = Mapping.new(build(type), attrs)
            support, attrs = split(attrs, :only, :except)
            attrs = attrs.merge(supports: support) if support.any?
            mappings[key] = build(type, attrs)
          end

          def mappings
            @mappings ||= defined?(super) ? super.dup : {}
          end

          def includes?
            includes.any?
          end

          def includes(*includes)
            return @includes ||= [] unless includes.any?
            includes = includes.map { |type| build(type) }
            self.includes.concat(includes)
          end

          def expand_keys
            super + mappings.values.map(&:expand_keys).flatten + includes.map(&:expand_keys).flatten
          end

          def max_size(max_size)
            attrs[:max_size] = max_size
          end

          def prefix?
            !!prefix
          end

          def prefix(prefix = nil, opts = {})
            return attrs[:prefix] unless prefix
            attrs[:prefix] = { key: prefix }.merge(compact(only: to_syms(opts[:only])))
          end

          def required
            keys = mappings.values.select(&:required?).map(&:key)
            keys if keys.any?
          end

          def strict?
            return true if strict = attrs[:strict]
            mappings.any? && types.empty? && !false?(strict)
          end

          def strict(obj)
            attrs[:strict] = !false?(obj)
          end

          def opts
            compact(super.merge(required: required))
          end
        end

        class Schema < Map
          register :schema

          def type
            :schema
          end
        end
      end
    end
  end
end
