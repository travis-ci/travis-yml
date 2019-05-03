# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Alert < Base
          register :alert

          def apply
            apply? && alert? ? alert : value
          end

          private

            def apply?
              schema.secure? && schema.strict? && value.alert?
            end

            def alert?
              value.str? && !env_var?(value.value)
            end

            def env_var?(str)
              str.start_with?('$') && !str.include?(':$')
            end

            def alert
              value.alert :secure, type: value.type
              value
            end
        end
      end
    end
  end
end
