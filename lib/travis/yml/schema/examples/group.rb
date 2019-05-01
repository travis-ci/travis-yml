# frozen_string_literal: true
require 'travis/yml/schema/examples/node'

module Travis
  module Yml
    module Schema
      module Examples
        class Group < Node
          register :seq
        end

        class All < Group
          register :all
        end

        class One < Group
          register :one
        end

        class Any < Group
          register :any

          def examples
            expand.map(&:example).uniq
          end

          def expand
            node.map { |node| build(node).expand }.flatten
          end
        end
      end
    end
  end
end
