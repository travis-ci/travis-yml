# frozen_string_literal: true
require 'travis/yml/schema/type/opts'
require 'travis/yml/schema/type/scalar'

module Travis
  module Yml
    module Schema
      module Type
        class Str < Scalar
          include Opts

          register :str

          opts %i(downcase format vars)

          def self.type
            :str
          end
        end
      end
    end
  end
end

