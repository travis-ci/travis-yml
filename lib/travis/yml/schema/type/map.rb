# frozen_string_literal: true
require 'travis/yml/schema/type/node'
require 'travis/yml/schema/type/opts'

module Travis
  module Yml
    module Schema
      module Type
        class Map < Node
          extend Forwardable
          include Enumerable, Opts

          register :map

          opts %i(max_size prefix required)

          def self.type
            :map
          end

          def_delegators :mappings, :[]=, :[], :each, :keys, :key?, :values

          attr_writer :types, :mappings

          def types
            @types ||= []
          end

          def mappings
            @mappings ||= {}
          end

          def includes?
            includes.any?
          end

          def includes
            @includes ||= []
          end

          def max_size
            opts[:max_size]
          end

          def prefix?
            !!prefix
          end

          def prefix
            opts[:prefix]
          end

          def strict?
            mappings.empty? || false?(@strict) ? false : true
          end

          def dup
            node = super
            node.types = node.types.map(&:dup)
            node.mappings = node.map { |key, node| [key, node.dup] }.to_h
            node
          end

          def to_h
            Dump.new(self).to_h
          end
        end
      end
    end
  end
end
