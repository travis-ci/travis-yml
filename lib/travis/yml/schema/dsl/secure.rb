# frozen_string_literal: true
require 'travis/yml/schema/dsl/scalar'

module Travis
  module Yml
    module Schema
      module Dsl
        class Secure < Scalar
          register :secure

          def self.type
            :secure
          end

          def strict(value = true)
            node.set :strict, value
          end
        end
      end
    end
  end
end
