# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Conditions < Type::Str
          register :conditions

          def define
            summary 'Conditions support version'
            # default :v1
            value :v0
            value :v1
            internal
            export
          end
        end

        class Condition < Type::Str
          register :condition

          def define
            summary 'Condition to determine whether or not a build, stage, or job should be run'
            example 'branch = master'
            export
          end
        end
      end
    end
  end
end
