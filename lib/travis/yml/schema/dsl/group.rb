# frozen_string_literal: true
require 'travis/yml/schema/dsl/node'

module Travis
  module Yml
    module Schema
      module Dsl
        class Group < Node
          def type(*types)
            types = types.flatten
            opts = types.last.is_a?(Hash) ? types.pop : {}
            types = types.map { |type| build(self, type, opts).node }
            node.types.concat(types)
          end
          alias add type # remove this
          alias types type
        end
      end
    end
  end
end

