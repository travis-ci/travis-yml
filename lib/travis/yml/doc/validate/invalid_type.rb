# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class InvalidType < Base
          register :invalid_type

          def apply
            return value unless apply?
            return invalid_secure if invalid_secure?
            return invalid_type if invalid_type?
            value
          end

          private

            def apply?
              value.given?
            end

            def invalid_secure?
              schema.secure? && schema.strict? && value.secure? && !value.encoded?
            end

            def invalid_type?
              !schema.is?(value.type) || invalid_secure?
            end

            def invalid_secure
              value.warn :invalid_secure, value: value.serialize
              value
            end

            def invalid_type
              value.error :invalid_type, expected: schema.type, actual: value.type, value: value.serialize
              drop? ? blank : value
            end

            def drop?
              value.drop? && !(schema.scalar? && value.scalar?)
            end
        end
      end
    end
  end
end
