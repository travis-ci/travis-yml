# frozen_string_literal: true
require 'travis/yml/schema/dsl/group'

module Travis
  module Yml
    module Schema
      module Dsl
        class One < Group
          register :one

          def self.type
            :one
          end
        end
      end
    end
  end
end
