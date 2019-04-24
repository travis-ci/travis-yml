# frozen_string_literal: true
require 'travis/yml/schema/type/group'
require 'travis/yml/schema/type/opts'

module Travis
  module Yml
    module Schema
      module Type
        class Any < Group
          include Enumerable
          include Opts

          register :any

          opts %i(detect)

          def self.type
            :any
          end

          def detect=(obj)
            opts[:detect] = obj
          end
        end
      end
    end
  end
end
