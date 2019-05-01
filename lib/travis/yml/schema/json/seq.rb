# frozen_string_literal: true
require 'travis/yml/schema/json/node'

module Travis
  module Yml
    module Schema
      module Json
        class Seq < Node
          register :seq

          def_delegators :node, :prefix

          def to_h
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
