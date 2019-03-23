# frozen_string_literal: true
require 'travis/yml/schema/examples/scalar'

module Travis
  module Yml
    module Schema
      module Examples
        class Str < Scalar
          register :str

          def self.example
            'a string'
          end

          def example
            node.key ? titleize(node.key) : self.class.example
          end
        end
      end
    end
  end
end
