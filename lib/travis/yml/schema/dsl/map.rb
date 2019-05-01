# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Dsl
        class Map < Node
          register :map

          def self.type
            :map
          end

          def matrix(key, opts = {})
            node.root.expand_key(key)
            map(key, opts.merge(expand: key))
          end

          def maps(*keys)
            opts = keys.last.is_a?(Hash) ? keys.pop : {}
            keys.each { |key| map(key, opts) }
          end

          def map(key, opts = {})
            type = opts[:to] || key
            opts = { key: key }.merge(except(opts, :to))
            node[key] = build(self, type, opts).node
            node.set :required, [key] if node[key].required?
          end

          def type(*types)
            types = types.flatten
            node.set :types, types.map { |type| build(self, type).node }
            node.set :strict, false
          end

          def include(*types)
            types = types.map { |type| build(self, type).node }
            node.includes.concat(types)
          end

          def max_size(max_size)
            node.set :max_size, max_size
          end

          def prefix(prefix, opts = {})
            opts[:only] = to_syms(opts[:only])
            node.set :prefix, { key: prefix }.merge(opts)
          end

          def strict(obj = nil)
            node.set :strict, !false?(obj)
          end
        end
      end
    end
  end
end
