# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class InvalidType < Base
          register :invalid_type

          def apply
            apply? && invalid? ? invalid : value
          end

          private

            def apply?
              value.given?
            end

            def invalid?
              !schema.is?(value.type) && !(schema.enum? && value.scalar?) # ugh.
            end

            def invalid
              value.error :invalid_type, expected: expected, actual: actual, value: value.serialize unless value.nil?
              blank
            end

            def expected
              schema.type
            end

            def actual
              value.type
            end
        end
      end
    end
  end
end
