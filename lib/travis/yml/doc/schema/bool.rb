# frozen_string_literal: true
require 'travis/yml/doc/schema/scalar'

module Travis
  module Yml
    module Doc
      module Schema
        class Bool < Scalar

          def type
            :bool
          end
        end
      end
    end
  end
end
