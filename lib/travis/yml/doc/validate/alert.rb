# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Alert < Base
          register :alert

          def apply
            alert? ? alert : value
          end

          private

            def alert?
              schema.secure? && !value.secure? && value.alert?
            end

            def alert
              value.alert :secure
              value
            end
        end
      end
    end
  end
end
