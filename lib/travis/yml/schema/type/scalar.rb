# frozen_string_literal: true
require 'travis/yml/schema/type/node'
require 'travis/yml/schema/type/opts'

module Travis
  module Yml
    module Schema
      module Type
        class Scalar < Node
          include Opts

          register :scalar

          opts %i(defaults enum values)

          def enum?
            !enum.empty?
          end

          def enum
            opts[:enum]
          end

          def strict?
            false?(opts[:strict]) ? false : true
          end
        end
      end
    end
  end
end
