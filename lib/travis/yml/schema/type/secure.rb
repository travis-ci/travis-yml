# frozen_string_literal: true
require 'travis/yml/schema/type/scalar'

module Travis
  module Yml
    module Schema
      module Type
        class Secure < Scalar
          register :secure

          def self.type
            :secure
          end
        end
      end
    end
  end
end
