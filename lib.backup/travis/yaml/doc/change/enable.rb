# frozen_string_literal: true
require 'travis/yaml/doc/change/base'
require 'travis/yaml/helper/memoize'

module Travis
  module Yaml
    module Doc
      module Change
        class Enable < Base
          include Helper::Memoize

          KEYS = [:enabled, :disabled]

          def apply
            if !spec.map?
              node
            elsif bool?
              on_bool
            elsif node.map? && node.present? && enable?
              on_hash
            else
              node
            end
          end

          def enable?
            node.map? && keys != [:enabled]
          end

          def bool?
            node.bool?
          end

          def on_bool
            value = { enabled: node.value }
            value = build(node.parent, node.key, value, node.opts)
            other = node.parent.set(node.key, value)
            changed other
          end

          def on_hash
            key   = keys.first
            value = key ? value_for(key) : true
            value = !value if key == :disabled
            node.delete(node[:disabled]) if node.key?(:disabled)
            value = build(node, :enabled, value, node.opts)
            changed node.set(:enabled, value)
          end

          def keys
            KEYS.select { |key| node.key?(key) }
          end
          memoize :keys

          def value_for(key)
            node[key] && node[key].raw
          end
        end
      end
    end
  end
end
