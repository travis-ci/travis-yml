# frozen_string_literal: true
require 'travis/yml/schema/dsl/node'

module Travis
  module Yml
    module Schema
      module Dsl
        class Seq < Node
          register :seq

          def self.type
            :seq
          end

          def type(*types)
            opts = types.last.is_a?(Hash) ? types.pop : {}
            schemas = types.map { |type| Node.build(self, type).node }
            node.set :schemas, schemas
          end
        end
      end
    end
  end
end
