require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class InvalidType < Conform
          register :invalid_type

          TYPES = {
            Map: Hash,
          }

          NAMES = {
            Hash:       :mapping,
            Array:      :sequence,
            TrueClass:  :bool,
            FalseClass: :bool,
            Secure:     :secure
          }

          def apply?
            node.given? && node.relevant? && invalid_type?
          end

          def apply
            node.error :invalid_type, value.class.name, value
          end

          private

            def invalid_type?
              case node
              when Type::Map then !value.is_a?(Hash)
              when Type::Seq then !value.is_a?(Array)
              else value.is_a?(Hash)
              end
            end

            def value
              node.value
            end
        end
      end
    end
  end
end
