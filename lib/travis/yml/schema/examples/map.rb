# frozen_string_literal: true
require 'travis/yml/schema/examples/node'

module Travis
  module Yml
    module Schema
      module Examples
        class Map < Node
          register :map

          def examples
            expand.map(&:example)
          end

          def example
            obj = node.map do |key, child|
              next if key == :disabled || inherit?(key)
              # opts = { example: node.examples[key] }
              opts = { example: node.example }
              child = build(child, opts)
              [key, child.example]
            end.compact.to_h
          end

          def expand
            maps = []

            maps << required.merge(others).map do |key, node|
              nodes = Array(build(node).expand)
              nodes.map { |node| [key, node.node] }
            end.flatten(1).to_h

            anys.each do |key, any|
              nodes = Array(build(any).expand)
              nodes = nodes.map { |node| required.merge(key => node.node) }
              maps.concat nodes
            end

            maps.map { |map| Map.new(Type::Map.new(nil, mappings: map)) }
          end

          def required
            node.select { |_, node| node.required? }.to_h
          end

          def anys
            node.select { |_, node| node.type == :any }.to_h
          end

          def others
            except(node.mappings, *required.keys, *anys.keys)
          end

          def inherit?(key)
            inherits.any? { |change| Array(change[:keys]).include?(key) }
          end

          def inherits
            changes.select { |change| change[:change] == :inherit }
          end
          memoize :inherits

          def changes
            node.opts[:changes] || []
          end
          memoize :changes
        end
      end
    end
  end
end
