# frozen_string_literal: true
require 'travis/yml/schema/json/node'

module Travis
  module Yml
    module Schema
      module Json
        class Seq < Scalar
          register :seq

          def_delegators :node, :prefix

          def definitions
            defs = merge(*jsons(node).map(&:definitions))
            defs = merge(defn(to_h), defs) if export?
            defs.sort.to_h
          end

          private

            def to_h
              type = detect(:str, :secure)
              type ? ref("#{type}s", opts) : seq
            end

            def seq
              schema = { type: :array, items: items }
              schema = compact(schema.merge(opts))
              wrap(schema)
            end

            def wrap(schema)
              schemas = [schema] + jsons(node).map(&:schema)
              schemas = normals(flatten(schemas))
              any(schemas, opts)
            end

            def items
              items = jsons(node).map(&:schema)
              items.size > 1 ?  any(normals(items)) : items.first
            end

            def flatten(schemas)
              schemas.map { |schema| schema.key?(:anyOf) ? schema[:anyOf] : schema }.flatten
            end

            def any(schemas, opts = {})
              { anyOf: schemas }.merge(except(opts, :normal))
            end

            def detect(*types)
              types.detect { |type| all?(type) }
            end

            def all?(type)
              node.all?(&:"#{type}?") && node.none?(&:enum?) && node.none?(&:opts?)
            end
        end
      end
    end
  end
end
