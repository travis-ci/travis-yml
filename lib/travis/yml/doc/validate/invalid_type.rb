# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class InvalidType < Base
          register :invalid_type

          def apply
            # invalid_seq if apply? && invalid_seq?
            apply? && invalid_obj? ? invalid_obj : value
          end

          private

            def apply?
              value.given?
            end

            def invalid_seq?
              schema.seq? && value.seq? && !value.all? { |value| schema.schema.is?(value.type) }
            end

            def invalid_obj?
              !schema.is?(value.type) && !(schema.enum? && value.scalar?) # ugh.
            end

            # would need something like schema.full_type, which would have to be able to
            # resolve :any schemas
            #
            # def invalid_seq
            #   value.error :invalid_type, expected: :"seq(#{schema.schema.type})", actual: :"seq(#{value.type})", value: value.serialize
            #   blank
            # end

            def invalid_obj
              value.error :invalid_type, expected: schema.type, actual: value.type, value: value.serialize
              blank
            end
        end
      end
    end
  end
end
