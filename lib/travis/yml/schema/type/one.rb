# frozen_string_literal: true
require 'travis/yml/schema/type/group'

module Travis
  module Yml
    module Schema
      module Type
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
