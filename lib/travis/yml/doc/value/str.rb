# frozen_string_literal: true
require 'travis/yml/doc/value/scalar'

module Travis
  module Yml
    module Doc
      module Value
        class Str < Scalar
          def type
            :str
          end

          def is?(type)
            super || type == :enum
          end
        end
      end
    end
  end
end
