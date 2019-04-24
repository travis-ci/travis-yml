# frozen_string_literal: true
require 'travis/yml/schema/type/group'

module Travis
  module Yml
    module Schema
      module Type
        class All < Group
          include Enumerable

          register :all

          def self.type
            :all
          end
        end
      end
    end
  end
end
