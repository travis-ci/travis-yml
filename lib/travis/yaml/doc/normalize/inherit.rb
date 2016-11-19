require 'travis/yaml/doc/normalize/normalizer'

module Travis
  module Yaml
    module Doc
      module Normalize
        class Inherit < Normalizer
          register :inherit

          def apply
            inherit? ? inherit(value) : value
          end

          private

            def inherit?
              parent.value.is_a?(Hash) && value.is_a?(Hash) && keys.any?
            end

            def inherit(value)
              other = compact(only(parent.value, *keys))
              other.merge(value)
            end

            def keys
              spec[:keys] || []
            end
        end
      end
    end
  end
end
