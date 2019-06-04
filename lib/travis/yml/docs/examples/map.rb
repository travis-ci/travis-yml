# frozen_string_literal: true
require 'travis/yml/docs/examples/node'

module Travis
  module Yml
    module Docs
      module Examples
        class Map < Node
          register :map

          def examples
            return [node.example] if node.example

            expand.map do |map|
              map.map do |key, node|
                next if key == :disabled || inherit?(key)
                [key, build(node).example]
              end.compact.to_h
            end
          end

          def example
            examples.first
          end

          def expand
            nodes = []
            map = required.merge(others)

            nodes << map.map do |key, node|
              node = node.expand.first
              [key, node]
            end

            nodes + map.map do |key, node|
              nodes = node.expand
              nodes[1..-1].map { |node| [key, node] } if nodes.size > 1
            end.compact
          end

          def required
            node.select { |_, node| node.required? }.to_h
          end

          def others
            except(node.mappings, *required.keys).to_a[0, 3].to_h
          end

          def inherit?(key)
            inherits.any? { |change| Array(change[:keys]).include?(key) }
          end

          def inherits
            changes.select { |change| change[:change] == :inherit }
          end

          def changes
            node.opts[:changes] || []
          end
        end
      end
    end
  end
end
