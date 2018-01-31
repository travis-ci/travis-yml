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
              edge_key         if edge_key?
              edge_value       if edge_value?
              flagged          if spec.flagged?
              deprecated_key   if deprecated_key?
              deprecated_value if deprecated_value?
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

            def deprecated_key
              args = { given: node.key, info: info }
              node.warn :deprecated, args
            end

            def deprecated_key?
              spec.deprecated?
            end

            def deprecated_value
              args = { given: value.value, info: info }
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
