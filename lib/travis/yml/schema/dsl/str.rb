# frozen_string_literal: true
require 'travis/yml/schema/dsl/scalar'

module Travis
  module Yml
    module Schema
      module Dsl
        class Str < Scalar
          register :str

          def self.type
            :str
          end

          def downcase(*)
            node.set :downcase, true
          end

          def format(format)
            node.set :format, format
          end

          def vars(*vars)
            node.set :vars, vars.flatten
          end
        end
      end
    end
  end
end
