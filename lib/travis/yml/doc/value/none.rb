# frozen_string_literal: true
require 'travis/yml/doc/value/scalar'

module Travis
  module Yml
    module Doc
      module Value
        class None < Scalar
          def type
            :none
          end
        end
      end
    end
  end
end
