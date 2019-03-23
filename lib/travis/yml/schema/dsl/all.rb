# frozen_string_literal: true
require 'travis/yml/schema/dsl/group'

module Travis
  module Yml
    module Schema
      module Dsl
        class All < Group
          register :all

          def self.type
            :all
          end
        end
      end
    end
  end
end
