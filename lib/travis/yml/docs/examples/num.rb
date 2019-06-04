# frozen_string_literal: true
require 'travis/yml/docs/examples/scalar'

module Travis
  module Yml
    module Docs
      module Examples
        class Num < Scalar
          register :num

          def example
            1
          end
        end
      end
    end
  end
end
