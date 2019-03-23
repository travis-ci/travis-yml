# frozen_string_literal: true
require 'travis/yml/schema/examples/node'

module Travis
  module Yml
    module Schema
      module Examples
        class Group < Node
          register :seq

          def examples
            [example]
          end

          def example
            node.map { |node| build(node).example }
          end
        end

        class Any < Group
          register :any
        end

        class All < Group
          register :all
        end

        class One < Group
          register :one
        end
      end
    end
  end
end
