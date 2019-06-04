require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class Map < Group
          register :map

          opts %i(max_size prefix required strict)

          def self.type
            :map
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

          REMAP = {
            alias: :aliases,
            eg: :example,
            type: :types
          }

          def map(key, attrs = {})
            type = attrs[:to] || key
            attrs = except(attrs, :to).map { |key, obj| [REMAP[key] || key, obj] }.to_h
            attrs, support = split(attrs, :only, :except)
            mappings[key] = build(type, attrs.merge(key: key, supports: support))
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
