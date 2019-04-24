# frozen_string_literal: true
require 'travis/yml/schema/dsl/node'

module Travis
  module Yml
    module Schema
      module Dsl
        class Group < Node
          def add(*types)
            types = types.flatten
            opts = types.last.is_a?(Hash) ? types.pop : {}
            types = types.map { |type| build(self, type, opts).node }
            node.types.concat(types)
          end
        end
      end
    end
  end
end

