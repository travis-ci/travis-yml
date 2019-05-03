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
              value.alert?
            end

            def alert?
              schema.secure? && schema.strict? && value.str?
            end

            def alert
              value.alert :secure, given: value.type
              value
            end
        end
      end
    end
  end
end
