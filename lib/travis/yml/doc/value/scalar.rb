# frozen_string_literal: true
require 'travis/yml/doc/value/node'

module Travis
  module Yml
    module Doc
      module Value
        class Scalar < Node
          def scalar?
            true
          end

          def set(value)
            @value = value
            self
          end

          def clear
            set(nil)
          end
        end
      end
    end
  end
end
