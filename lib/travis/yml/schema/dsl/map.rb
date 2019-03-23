# frozen_string_literal: true

require 'travis/yml/schema/dsl/mapping'

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
            node.root.expand(key)
            map(key, opts)
          end

          def maps(*keys)
            opts = keys.last.is_a?(Hash) ? keys.pop : {}
            keys.each { |key| map(key, opts) }
          end

          def map(key, opts = {})
            type = opts[:to] || key
            opts = except(opts, :to).merge(key: key)

            child = Node.build(self, type)
            mapping = Mapping.new(key, child, opts).tap(&:define)
            node[key] = mapping.node

            node.set :keys, mapping.key_opts
          end

          def include(*types)
            types = types.map { |type| Node.build(self, type).node }
            node.includes.concat(types)
          end

          def max_size(max_size)
            node.set :max_size, max_size
          end

          def prefix(prefix)
            node.set :prefix, prefix
          end

          def strict(obj = nil)
            node.set :strict, false if false?(obj)
          end
        end
      end
    end
  end
end
