require 'travis/yaml/doc/normalize/normalizer'

module Travis
  module Yaml
    module Doc
      module Normalize
        class Vars < Normalizer
          register :vars

          def apply
            normalize(value)
          end

          private

            def normalize(value)
              case value
              when Hash  then on_hash(value)
              when Array then on_array(value)
              else value
              end
            end

            def on_hash(value)
              value.map { |key, value| [key, value].join('=') }
            end

            def on_array(value)
              value.map { |value| normalize(value) }.flatten
            end
        end
      end
    end
  end
end
