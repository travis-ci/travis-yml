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

          def definitions
            defs = merge(*jsons(values).map(&:definitions))
            defs = merge(defs, defn(to_h)) if export?
            defs.sort.to_h
          end

          def to_h
            schema = {
              type: :object,
              properties: properties,
              patternProperties: pattern_properties,
              additionalProperties: strict? ? false : nil,
            }
            schema = compact(schema.merge(opts))
            schema = includes(schema) if node.includes.any?
            # schema = prefix(schema) if node.prefix?
            schema
          end

          private

            def includes(schema)
              compact(
                allOf: [schema, *jsons(node.includes).map(&:schema)],
                normal: schema[:normal]
              )
            end

            # def prefix(schema)
            #   { anyOf: normals([schema, json(node[node.prefix]).schema]) }
            # end

            def properties
              map = except(node, *patterns)
              map.map { |key, node| [key, json(node).schema] }.to_h if map.any?
            end

            def pattern_properties
              map = only(node, *patterns)
              map.map { |key, node| [key, json(node).schema] }.to_h if map.any?
            end

            def patterns
              @patterns ||= node.keys.select { |key| key.to_s =~ PATTERN }
            end

            def opts
              merge(except(super, :keys), super[:keys] || {})
            end

            def remap(opts)
              opts.map { |key, value| [REMAP[key] || key, value] }.to_h
            end
        end
      end
    end
  end
end
