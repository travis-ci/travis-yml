# frozen_string_literal: true
require 'travis/yml/schema/examples/node'

module Travis
  module Yml
    module Schema
      module Examples
        class Seq < Node
          register :seq

          def examples
            [example]
          end

          def example
            node.map { |node| build(node).example }
          end
        end
      end
    end
  end
end
