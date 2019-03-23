# frozen_string_literal: true
require 'travis/yml/schema/json/schema'
require 'travis/yml/schema/type/map'

module Travis
  module Yml
    module Schema
      module Type
        class Schema < Map
          register :schema

          def self.type
            :schema
          end

          attr_accessor :title

          def strict?
            false
          end
        end
      end
    end
  end
end
