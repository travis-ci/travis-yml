# frozen_string_literal: true
require 'travis/yml/schema/dsl/scalar'

module Travis
  module Yml
    module Schema
      module Dsl
        class Num < Scalar
          register :num

          def self.type
            :num
          end
        end
      end
    end
  end
end
