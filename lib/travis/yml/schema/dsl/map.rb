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
            opts = { key: key }.merge(except(opts, :to))

            node[key] = Node.build(self, type, except(opts, :required, :only, :except)).node

            # ugh.

            obj = node[key]
            obj = obj.lookup if obj.type == :ref

            node.set :keys, unique: [key] if opts[:unique] || obj.unique?
            node.set :keys, required: [key] if opts[:required] || obj.required?
            node.set :keys, only: { key => to_strs(opts[:only]) } if opts[:only]
            node.set :keys, except: { key => to_strs(opts[:except]) } if opts[:except]
            obj.support.each do |type, opts|
              node.set :keys, type => { key => to_strs(opts) }
            end
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
