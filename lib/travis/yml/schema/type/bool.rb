# frozen_string_literal: true
require 'travis/yml/schema/type/scalar'

module Travis
  module Yml
    module Schema
      module Type
        class Bool < Scalar
          register :bool

          def self.type
            :bool
          end
        end
      end
    end
  end
end
