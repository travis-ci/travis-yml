require 'travis/yaml/doc/validate/validator'
require 'travis/yaml/support/version'

module Travis
  module Yaml
    module Doc
      module Validate
        class Version < Validator
          register :version

          DEFAULT = '~> 1.0.0'

          def apply
            invalid? ? invalid : node
          end

          private

            def invalid?
              # TODO should be able to version other types, too
              spec.fixed? && node.scalar? && version? && !satisfied?
            end

            def invalid
              node.error :invalid_version, key: node.key, version: given, required: required
            end

            def version?
              !!given
            end

            def satisfied?
              ::Version.new(given).satisfies?(required)
            end

            def given
              @given ||= spec.version || value && value.version
            end

            def required
              @required ||= begin
                version = node.root[:version]
                version ? version.raw : DEFAULT
              end
            end

            def value
              @value ||= spec.values.detect { |value| value == node.value }
            end
        end
      end
    end
  end
end
