# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/change/key'

module Travis
  module Yml
    module Doc
      module Change
        class Keys < Base
          INTERNAL = /^\W*(configured|result|fetching_failed|parsing_failed)\W*$/

          def apply
            apply? ? change(value) : value
          end

          private

            def apply?
              schema.map? && schema.strict? && value.map?
            end

            def change(value)
              value = required(value) if defaults?
              value = internal(value)
              value = fix_keys(value)
              value
            end

            def required(node)
              keys = schema.required.map { |key| ::Key.new(key) }
              keys = concat(keys, value.keys).uniq
              build(keys.map { |key| [key, value[key] || none] }.to_map)
            end

            def internal(value)
              value.keys.each do |key|
                value.delete(key) if INTERNAL =~ key
              end
              value
            end

            def fix_keys(value)
              value.keys.inject(value) do |parent, key|
                next parent if known?(key) || custom?(key)
                node = parent[key]
                key  = Key.new(schema, node, opts).apply
                next parent if key == node.key && known?(key)
                parent.move(node.key, node.key.copy(key))
                parent
              end
            end

            def custom?(key)
              schema.custom?(key)
            end

            def known?(key)
              schema.key?(key)
            end

            def strict?
              schema.strict?
            end

            def defaults?
              value.enabled?(:defaults)
            end

            # Keep the order of keys, but use the key from the right hand side if
            # present on both sides.
            def concat(lft, rgt)
              lft = lft.map { |key| (ix = rgt.index(key)) ? rgt[ix] : key }
              lft.concat(rgt)
            end
        end
      end
    end
  end
end
