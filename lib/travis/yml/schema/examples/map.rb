# frozen_string_literal: true
require 'travis/yml/schema/examples/node'

module Travis
  module Yml
    module Schema
      module Examples
        class Map < Node
          register :map

          def examples
            [example]
          end

          def example
            node.map do |key, node|
              next if key == :disabled || inherit?(key)
              [key, build(node).example]
            end.compact.to_h
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
