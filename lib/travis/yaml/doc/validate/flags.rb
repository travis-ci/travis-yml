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
              edge       if spec.edge?
              flagged    if spec.flagged?
              deprecated if deprecated?
            end

            def edge
              node.info :edge, key: node.key
            end

            def flagged
              node.info :flagged, key: node.key
            end

            def deprecated?
              spec.deprecated? || deprecated_value?
            end

            def deprecated
              args = { key: node.key, info: info }
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
