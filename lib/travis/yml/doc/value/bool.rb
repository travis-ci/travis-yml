# frozen_string_literal: true
require 'travis/yml/doc/value/scalar'

module Travis
  module Yml
    module Doc
      module Value
        class Bool < Scalar
          def type
            :bool
          end
        end
      end
    end
  end
end
