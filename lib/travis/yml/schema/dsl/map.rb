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
            node.root.expand(key)
            map(key, opts.merge(expand: key))
          end

          def maps(*keys)
            opts = keys.last.is_a?(Hash) ? keys.pop : {}
            keys.each { |key| map(key, opts) }
          end

          def map(key, opts = {})
            type = opts[:to] || key
            opts = { key: key }.merge(except(opts, :to))

            node[key] = build(self, type, except(opts, :alias, :only, :except)).node # :required

            mapped_opts(node[key], key, opts).each do |key, opts|
              node.set key, opts
            end
          end

          def include(*types)
            types = types.map { |type| build(self, type).node }
            node.includes.concat(types)
          end

          def max_size(max_size)
            node.set :max_size, max_size
          end

          def prefix(prefix)
            node.set :prefix, prefix
          end

          def strict(obj = nil)
            node.set :strict, !false?(obj)
          end

          # These can all be passed as options to #map, or defined on the
          # mapped type, but need to end up on the map.
          def mapped_opts(obj, key, mapped)
            obj = obj.lookup if obj.is?(:ref)
            obj = obj.schemas.detect(&:map?) || obj if obj.is?(:any) # hmmm.
            obj = obj.schemas.detect(&:seq?) || obj if obj.is?(:any)

            opts = %i(alias).map do |attr|
              [:keys, { key => { aliases:  to_syms(mapped[attr]) } }] if mapped[attr]
            end.compact.to_h

            opts = merge(opts, %i(required unique).map do |attr|
              [attr, [key]] if mapped[attr] || obj.send("#{attr}?")
            end.compact.to_h)

            opts = merge(opts, %i(only except).map do |attr|
              [:keys, { key => { attr => to_strs(mapped[attr]) } }] if mapped[attr]
            end.compact.to_h)

            opts = merge(opts, %i(aliases).map do |attr|
              [:keys, { key => { attr => to_syms(obj.send(attr)) } }] if obj.send(:"#{attr}?")
            end.compact.to_h)

            opts = merge(opts, obj.support.map { |attr, opts|
              [:keys, { key => { attr => to_strs(opts) } }]
            }.to_h)

            opts
          end
        end
      end
    end
  end
end
