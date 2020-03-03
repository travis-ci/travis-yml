require 'travis/yml/docs/schema/node'

module Travis
  module Yml
    module Docs
      module Schema
        class Map < Node
          include Enumerable

          attr_accessor :mappings, :schema, :includes

          def [](key)
            mappings[key]
          end

          def each(&block)
            mappings.each(&block)
          end

          def includes
            @includes ||= []
          end

          def dup
            node = super
            node.mappings = mappings.map { |key, obj| [key, obj.dup] }.to_h
            # node.includes = includes.map(&:dup)
            node
          end
        end
      end
    end
  end
end
