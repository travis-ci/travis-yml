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

          def clone
            node = super
            node.mappings = mappings.map { |key, obj| [key, obj.clone] }.to_h
            # node.includes = includes.map(&:clone)
            node
          end
        end
      end
    end
  end
end
