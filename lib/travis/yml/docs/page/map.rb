require 'travis/yml/docs/page/base'

module Travis
  module Yml
    module Docs
      module Page
        class Map < Base
          include Enumerable

          def_delegators :mappings, :each, :[]

          attr_reader :includes, :mappings

          def initialize(node)
            @mappings = node.map { |key, schema| [key, build(schema)] }.reject { |_, node| node.internal? }.to_h
            @includes = node.includes.map { |schema| build(schema) }
            super
          end

          def render(name = :map, opts = {})
            super
          end

          def pages
            [self, *includes.map(&:pages), *mappings.values.map(&:pages)].flatten
          end

          # def walk(obj = nil, &block)
          #   yield *[obj].compact, self
          #   mappings.each { |_, page| page.walk(*[obj].compact, &block) }
          #   obj
          # end
        end
      end
    end
  end
end
