# frozen_string_literal: true
require 'travis/yml/schema/examples/node'

module Travis
  module Yml
    module Schema
      module Examples
        class Seq < Node
          register :seq

          def example
            node.map { |node| build(node).examples }.flatten
          end

          def expand
            nodes = node.map { |node| build(node).expand }.flatten.map(&:node)
            nodes.map { |node| Seq.new(Type::Seq.new(nil, types: [node])) }
          end
        end
      end
    end
  end
end
