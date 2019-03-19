# frozen_string_literal: true
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class UnknownKeys < Validator
          register :unknown_keys

          def apply
            apply? ? drop_unknown : node
          end

          private

            def apply?
              node.map? && spec.map? && spec.strict? && node.present?
            end

            def drop_unknown
              node.keys.inject(node) do |node, key|
                unknown?(node[key]) ? unknown(node, node[key]) : node
              end
            end

            def unknown(parent, node)
              type = misplaced?(node.key) ? :misplaced_key : :unknown_key
              unless node.key.to_s.start_with?('_')
                parent.msg :error, type, key: node.key, value: node.raw
              end
              parent.delete(node)
            end

            def unknown?(node)
              node.present? && !spec.key?(node.key)
            end

            def misplaced?(key)
              Yaml.keys.include?(key)
            end
        end
      end
    end
  end
end
