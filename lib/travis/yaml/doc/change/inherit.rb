# frozen_string_literal: true
require 'travis/yaml/doc/change/base'

module Travis
  module Yaml
    module Doc
      module Change
        class Inherit < Base
          include Helper::Common

          def apply
            inherit? ? inherit : node
          end

          private

            def inherit?
              parent && !keys.empty? && inheritable? && !inherited?
            end

            def inheritable?
              parent.map? && node.map? && keys.any? { |key| parent.key?(key) }
            end

            def inherited?
              keys.all? do |key|
                next true if !parent.key?(key) || node.key?(key)
                key == :disabled && node.key?(:enabled) # ugh.
              end
            end

            def inherit
              keys.inject(node) do |node, key|
                value = parent[key]
                value ? inherit_value(node, key, value.raw) : node
              end
            end

            def inherit_value(node, key, value)
              node.set(key, build(node, key, value, node.opts))
            end

            def keys
              opts[:keys] || []
            end

            def parent
              node.parent
            end
        end
      end
    end
  end
end
