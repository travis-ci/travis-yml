# frozen_string_literal: true
require 'travis/yml/schema/type/opts'
require 'travis/yml/schema/type/scalar'
require 'travis/yml/schema/type/str'

module Travis
  module Yml
    module Schema
      module Type
        class Enum < Str
          include Opts

          register :enum

          opts %i(enum values)

          def self.type
            :enum
          end

          def strict?
            false?(opts[:strict]) ? false : true
          end
        end
      end
    end
  end
end
