# frozen_string_literal: true
require 'travis/yml/schema/dsl/group'

module Travis
  module Yml
    module Schema
      module Dsl
        class Any < Group
          register :any

          def self.type
            :any
          end

          def detect(detect = nil)
            node.detect = detect
          end
        end
      end
    end
  end
end
