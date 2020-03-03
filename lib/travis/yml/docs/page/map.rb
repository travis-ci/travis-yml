require 'travis/yml/docs/page/base'

module Travis
  module Yml
    module Docs
      module Page
        class Map < Base
          include Enumerable

          def_delegators :mappings, :each, :[]

          attr_reader :includes, :mappings

          def initialize(parent, key, node, opts)
            super
            @mappings = node.map { |key, schema| [key, build(self, key, schema)] }.reject { |_, node| node.internal? }.to_h
            @includes = node.includes.map { |schema| build(self, key, schema) }
          end

          def pages
            [self, *includes.map(&:pages), *mappings.values.map(&:pages)].flatten.select(&:publish?)
          end

          def children
            # return [] if id == :deploys || id == :deploy
            [mappings.values, includes.map(&:children)].flatten.select(&:publish?).reject(&:deprecated?)
          end
        end
      end
    end
  end
end
