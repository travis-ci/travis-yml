# frozen_string_literal: true
require 'travis/yml/doc/validate/base'
require 'travis/yml/support/version'

module Travis
  module Yml
    module Doc
      module Validate
        class Version < Base
          register :version

          DEFAULT = '~> 1.0.0'

          def apply
            invalid? ? invalid : value
          end

          private

            def invalid?
              schema.root?
            end

            def invalid
              value.error :invalid_version, key: value.key, version: version, required: required
            end

            def version?
              !!version
            end

            def satisfied?
              ::Version.new(version).satisfies?(required)
            end

            def version
              schema.version
            end

            def required
              @required ||= begin
                version = value.root[:version]
                version ? version.raw : DEFAULT
              end
            end
        end
      end
    end
  end
end
