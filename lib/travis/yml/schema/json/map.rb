# frozen_string_literal: true
require 'travis/yml/schema/json/node'

module Travis
  module Yml
    module Schema
      module Json
        class Map < Node
          register :map

          PATTERN = /[\(\?\!\^\.\*\+]+/

          REMAP = {
            max_size: :maxProperties
          }

          def_delegators :node, :values, :keys, :max_size, :strict?, :prefix?,
            :prefix

          def to_h
            schema = {
              type: :object,
              properties: properties,
              patternProperties: pattern_properties,
              additionalProperties: strict? ? false : nil,
            }
            compact(schema.merge(opts))
          end

          private

            def properties
              map = except(node, *patterns)
              map.map { |key, node| [key, node.schema] }.to_h if map.any?
            end

            def pattern_properties
              case node.types.size
              when 0
                map = only(node, *patterns)
                map.map { |key, node| [key, node.schema] }.to_h if map.any?
              when 1
                { '.*': node.types.first.schema }
              when 2
                { '.*': any(node.types) }
              end
            end

            def patterns
              @patterns ||= node.keys.select { |key| key.to_s =~ PATTERN }
            end

            def remap(opts)
              opts.map { |key, value| [REMAP[key] || key, value] }.to_h
            end

            def any(nodes, opts = {})
              any = { anyOf: nodes.map(&:schema) }
              any.merge(except(opts, :normal))
            end
        end
      end
    end
  end
end
