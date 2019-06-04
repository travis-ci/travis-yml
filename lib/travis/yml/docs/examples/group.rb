# frozen_string_literal: true
require 'travis/yml/docs/examples/node'

module Travis
  module Yml
    module Docs
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
            node.types.map { |type| build(type).expand }.flatten
          end
        end
      end
    end
  end
end
