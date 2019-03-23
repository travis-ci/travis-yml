# frozen_string_literal: true
require 'travis/yml/schema/type/scalar'

module Travis
  module Yml
    module Schema
      module Type
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
