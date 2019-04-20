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
              schema = { type: :array, items: items }
              schema = compact(schema.merge(opts))
            end

            def items
              case node.size
              when 0 then { type: :string }
              when 1 then json(node.first).schema
              else any(jsons(node).map(&:schema))
              end
            end

            def any(schemas, opts = {})
              { anyOf: normals(schemas) }.merge(except(opts, :normal))
            end
        end
      end
    end
  end
end
