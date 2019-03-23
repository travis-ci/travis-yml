# frozen_string_literal: true
require 'travis/yml/schema/dsl/schema'

module Travis
  module Yml
    module Schema
      module Dsl
        class Schema < Map
          register :schema

          def self.type
            :schema
          end

          def title(title)
            node.title = title
          end
        end
      end
    end
  end
end
