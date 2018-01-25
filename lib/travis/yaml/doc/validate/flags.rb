require 'travis/yaml/doc/helper/support'
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class Flags < Validator
          include Helper::Support

          register :flags

          def apply
            flag if node.present? && relevant?
            node
          end

          private

            def flag
              edge_key   if edge_key?
              edge_value if edge_value?
              flagged    if spec.flagged?
              deprecated if deprecated?
            end

            def edge_key
              node.info :edge, given: node.key
            end

            def edge_key?
              spec.edge?
            end

            def edge_value
              node.info :edge, given: node.value
            end

            def edge_value?
              spec.fixed? && !!spec.values.find { |v| v.edge? && v.value == node.value }
            end

            def flagged
              node.info :flagged, given: node.key
            end

            def deprecated?
              spec.deprecated? || deprecated_value?
            end

            def deprecated
              args = { given: node.key, info: info }
              args[:value] = value.value if deprecated_value? && value
              node.warn :deprecated, args
            end

            def deprecated_value?
              spec.fixed? && node.scalar? && value && value.deprecated?
            end

            def info
              deprecated_value? ? value.deprecated : spec.deprecated
            end

            def value
              @value ||= spec.values.detect { |value| value == node.value }
            end
        end
      end
    end
  end
end
