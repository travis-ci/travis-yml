# frozen_string_literal: true
require 'travis/yml/doc/change/base'

module Travis
  module Yml
    module Doc
      module Change
        class Downcase < Base
          def apply
            apply? && downcase? ? downcase : value
          end

          private

            def apply?
              schema.str? && !schema.secure? && value.str? && value.given?
            end

            def downcase?
              schema.downcase? && downcased != str
            end

            def downcase
              value.info :downcase, value: str
              value.set(downcased)
              value
            end

            def str
              value.value
            end

            def downcased
              str.downcase
            end
        end
      end
    end
  end
end
