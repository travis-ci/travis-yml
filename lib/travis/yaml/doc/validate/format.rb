require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class Format < Validator
          register :format

          def apply
            invalid? ? invalid : node
          end

          private

            def invalid?
              spec.format && node.value !~ spec.format
            end

            def invalid
              node.error :invalid_format, value: node.value
            end
        end
      end
    end
  end
end
