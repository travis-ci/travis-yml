# frozen_string_literal: true
require 'travis/yml/schema/examples/scalar'

module Travis
  module Yml
    module Schema
      module Examples
        class Enum < Scalar
          register :enum

          def example
            enum.first
          end

          def enum
            node.opts[:enum] || []
          end
        end
      end
    end
  end
end
