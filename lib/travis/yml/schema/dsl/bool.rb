# frozen_string_literal: true
require 'travis/yml/schema/dsl/scalar'

module Travis
  module Yml
    module Schema
      module Dsl
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
