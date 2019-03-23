# frozen_string_literal: true
require 'travis/conditions'
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Condition < Base
          register :condition

          KEYWORDS = %i(type fork repo head_repo branch head_branch tag
            sender env)

          def apply
            apply? ? validate : value
          end

          private

            def apply?
              value.key == :if && value.str?
            end

            def validate
              Conditions.parse(value.value.to_s, keys: KEYWORDS, version: version)
              value
            rescue Conditions::ParseError
              invalid_condition
              blank
            end

            def invalid_condition
              value.error :invalid_condition, condition: value.value
            end

            def version
              value.root[:conditions]&.value == 'v0' ? :v0 : :v1
            end
        end
      end
    end
  end
end
