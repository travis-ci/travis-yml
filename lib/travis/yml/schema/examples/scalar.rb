# frozen_string_literal: true
require 'travis/yml/schema/examples/node'

module Travis
  module Yml
    module Schema
      module Examples
        class Scalar < Node
          def examples
            [example]
          end

          def example
            self.class.example
          end

          def enum?
            node.enum?
          end

          def enum
            node.opts[:enum] || []
          end
        end
      end
    end
  end
end
