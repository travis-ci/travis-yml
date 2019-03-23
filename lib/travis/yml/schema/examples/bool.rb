# frozen_string_literal: true
require 'travis/yml/schema/examples/scalar'

module Travis
  module Yml
    module Schema
      module Examples
        class Bool < Scalar
          register :bool

          def self.example
            true
          end
        end
      end
    end
  end
end
