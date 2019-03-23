# frozen_string_literal: true
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class Alert < Validator
          register :alert

          def apply
            alert? ? alert : node
          end

          private

            def alert?
              spec.secure? && node.scalar? && node.alert?
            end

            def alert
              node.error :alert
            end
        end
      end
    end
  end
end
