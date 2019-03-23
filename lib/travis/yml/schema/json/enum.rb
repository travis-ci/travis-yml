# frozen_string_literal: true
require 'travis/yml/schema/json/scalar'

module Travis
  module Yml
    module Schema
      module Json
        class Enum < Scalar
          register :enum
        end
      end
    end
  end
end
