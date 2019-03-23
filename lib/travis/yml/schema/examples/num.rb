# frozen_string_literal: true
require 'travis/yml/schema/examples/scalar'

module Travis
  module Yml
    module Schema
      module Examples
        class Num < Scalar
          register :num

          def self.example
            1
          end
        end
      end
    end
  end
end
