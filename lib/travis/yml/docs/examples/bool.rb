# frozen_string_literal: true
require 'travis/yml/docs/examples/scalar'

module Travis
  module Yml
    module Docs
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
