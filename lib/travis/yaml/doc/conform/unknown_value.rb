require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class UnknownValue < Conform
          register :unknown_value

          def apply?
            node.present? && unknown?
          end

          def apply
            node.default? ? unknown_default : unknown_value
          end

          private

            def unknown_default
              node.warn :unknown_default, node.value, default
              node.value = default
            end

            def unknown_value
              node.error :unknown_value, node.value
            end

            def unknown?
              node.values.none? { |value| value == node.value }
            end

            def default
              node.default[:value]
            end
        end
      end
    end
  end
end
