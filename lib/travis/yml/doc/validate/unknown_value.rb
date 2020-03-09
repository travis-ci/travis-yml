# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class UnknownValue < Base
          register :unknown_value

          def apply
            apply? && unknown? ? unknown : value
          end

          private

            def apply?
              schema.enum? && value.scalar? && value.given?
            end

            def unknown?
              !schema.known?(value.value)
            end

            def unknown
              value.error :unknown_value, value: value.value
              drop? ? none : value
            end

            def drop?
              value.drop?
            end
        end
      end
    end
  end
end
