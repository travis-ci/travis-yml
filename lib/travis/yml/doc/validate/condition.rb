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
            apply? && condition? ? validate : value
          end

          private

            def apply?
              schema.map? && schema.key?('if') && value.map?
            end

            def condition?
              condition&.str?
            end

            def condition
              value['if']
            end

            def validate
              Conditions.parse(condition.value.to_s, keys: KEYWORDS, version: version)
              value
            rescue Conditions::ParseError
              invalid_condition
              blank
            end

            def invalid_condition
              condition.error :invalid_condition, condition: condition.value
            end

            def version
              value.root['conditions']&.value == 'v0' ? :v0 : :v1
            end
        end
      end
    end
  end
end
