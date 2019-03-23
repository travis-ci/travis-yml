# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Format < Base
          register :format

          def apply
            apply? && invalid? ? invalid : value
          end

          private

            def apply?
              schema.str? && !schema.secure? && schema.format && value.value
            end

            def invalid?
              value.value !~ Regexp.new(schema.format)
            end

            def invalid
              value.error :invalid_format, format: schema.format, value: value.value
              none
            end
        end
      end
    end
  end
end
