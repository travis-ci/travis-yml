# frozen_string_literal: true
require 'travis/yml/doc/schema/scalar'

module Travis
  module Yml
    module Doc
      module Schema
        class Num < Scalar

          def type
            :num
          end
        end
      end
    end
  end
end
