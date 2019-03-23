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

          opts %i(defaults)
        end
      end
    end
  end
end
