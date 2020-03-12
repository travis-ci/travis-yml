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
              data = KEYWORDS.zip(Array.new(KEYWORDS.size)).to_h
              Conditions.eval(condition.value.to_s, data, version: version)
              value
            rescue Conditions::Error => e
              msg = version == :v1 ? e.message : 'unkonwn error'
              invalid_condition(msg)
              blank
            end

            def invalid_condition(msg)
              # will have to improve parse error messages
              condition.error :invalid_condition, condition: condition.value #, message: msg
            end

            def version
              value.root['conditions']&.value == 'v0' ? :v0 : :v1
            end
        end
      end
    end
  end
end
