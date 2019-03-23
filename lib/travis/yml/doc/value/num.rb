# frozen_string_literal: true
require 'travis/yml/doc/value/scalar'

module Travis
  module Yml
    module Doc
      module Value
        class Num < Scalar
          def type
            :num
          end
        end
      end
    end
  end
end
