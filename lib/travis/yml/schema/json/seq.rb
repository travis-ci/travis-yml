# frozen_string_literal: true
require 'travis/yml/schema/json/node'

module Travis
  module Yml
    module Schema
      module Json
        class Seq < Scalar
          register :seq

          def_delegators :node, :prefix

          # def definitions
          #   # # defs = merge(*jsons(node).map(&:definitions))
          #   # defs = {}
          #   # defs = merge(defn(to_h), defs) if export?
          #   # defs.sort.to_h
          #   fail
          # end

          def to_h
            # puts caller[0..10]
            # puts
            schema = { type: :array, items: items }
            compact(schema.merge(opts))
          end

          private

            def items
              case node.size
              when 0 then { type: :string }
              when 1 then node.first.schema
              else any(node.map(&:schema))
              end
            end

            def any(schemas, opts = {})
              { anyOf: schemas }.merge(except(opts, :normal))
            end
        end
      end
    end
  end
end
