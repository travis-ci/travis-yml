require 'travis/yaml/doc/change/base'

module Travis
  module Yaml
    module Doc
      module Change
        class Pick < Base
          def apply
            pick? ? pick : node
          end

          def pick?
            node.seq? && !spec.seq? && node.present?
          end

          def pick
            case node.parent.type
            when :map then pick_map
            when :seq then pick_seq
            else raise UnexpectedParentType, node.parent.type
            end
          end

          def pick_map
            node.warn :invalid_seq, value: node.first.raw
            parent = node.parent.set(node.key, node.first)
            changed parent
          end

          def pick_seq
            node.warn :invalid_seq, value: node.parent.raw
            values = node.raw.flatten
            values = values.map { |value| build(value) }
            changed node.parent.replace(node, *values)
          end

          def build(value)
            build(node.parent, node.key, value, node.opts)
          end
        end
      end
    end
  end
end
