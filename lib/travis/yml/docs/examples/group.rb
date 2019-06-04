# frozen_string_literal: true
require 'travis/yml/docs/examples/node'

module Travis
  module Yml
    module Docs
      module Examples
        class Group < Node
        end

        # class All < Group
        #   register :all
        # end
        #
        # class One < Group
        #   register :one
        # end

        class Any < Group
          register :any

          def examples
            node.expand.map { |node| build(node).example }.uniq
          end

          def example
            examples.first
          end
        end

        class Seq < Node
          register :seq

          def example
            return [node.example] if node.example
            build(node.schema).examples
          end
        end
      end
    end
  end
end
