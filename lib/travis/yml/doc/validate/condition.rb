# frozen_string_literal: true
require 'travis/conditions'
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Condition < Base
          register :condition

          KEYWORDS = %i(type fork repo head_repo branch head_branch tag draft
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
              invalid_condition(e)
              drop? ? blank : value
            end

            def invalid_condition(e)
              # improve parse error messages
              msg = e.message if version == :v1
              msg = nil if msg.to_s =~ /^(Could not parse|expected)/
              condition.error :invalid_condition, condition: condition.serialize, message: msg
            end

            def version
              value.root['conditions']&.value == 'v0' ? :v0 : :v1
            end

            def drop?
              value.drop?
            end
        end
      end
    end
  end
end
