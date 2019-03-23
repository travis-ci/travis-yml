# frozen_string_literal: true
require 'travis/yml/schema/dsl/node'

module Travis
  module Yml
    module Schema
      module Dsl
        class Group < Node
          def add(*types)
            opts = types.last.is_a?(Hash) ? types.pop : {}
            schemas = types.map { |type| Node.build(self, type, opts).node }
            node.schemas.concat(schemas)
          end
        end
      end
    end
  end
end

