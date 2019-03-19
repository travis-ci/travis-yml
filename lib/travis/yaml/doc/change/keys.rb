# frozen_string_literal: true
require 'travis/yaml/doc/helper/keys'
require 'travis/yaml/doc/change/base'
require 'travis/yaml/doc/change/migrate'
require 'travis/yaml/doc/change/key'
require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Doc
      module Change
        class Keys < Base
          include Helper::Common

          def apply
            node.map? ? change(node) : node
          end

          private

            def change(node)
              node = order(node) if order?(node)
              node = fix_keys(node)
              node
            end

            def order?(node)
              ordered_keys != node.keys
            end

            def order(node)
              other = build(node.parent, node.key, {}, node.opts)
              ordered_keys.uniq.inject(other) do |other, key|
                value = node[key] || build(nil, key, nil, other.opts)
                value.parent = other
                other.value[key] = value
                other
              end
            end

            def fix_keys(node)
              node.keys.inject(node) do |parent, key|
                next parent if known?(key)
                node = parent[key]
                key  = Key.new(spec, node, opts).apply
                next parent if key == node.key && known?(key)
                parent.move(node.key, key)
                next parent if known?(key)
                migrate(node) || parent
              end
            end

            def merge(node, other)
              return other unless spec.map?
              type = Spec.detect_type(nil, spec.map[node.key], node)
              case type.type
              when :seq
                value = Array(other.raw).concat(Array(node.raw))
                build(nil, other.key, value, node.opts)
              when :map
                value = Helper::Merge.apply(other.raw, node.raw)
                value.is_a?(Hash) ? build(nil, other.key, value, node.opts) : other
              else
                other
              end
            end

            def migrate(node)
              Migrate.new(spec, node, opts).apply
            end

            def ordered_keys
              @ordered_keys ||= begin
                keys = spec.required_keys + node.keys
                keys.uniq
              end
            end

            def known?(key)
              spec.key?(key)
            end

            def strict?
              spec.strict?
            end
        end
      end
    end
  end
end
