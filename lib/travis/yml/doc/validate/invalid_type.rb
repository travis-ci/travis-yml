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
              !schema.is?(value.type)
            end

            def invalid
              value.error :invalid_type, expected: schema.type, actual: value.type, value: value.serialize
              blank
            end
        end
      end
    end
  end
end
