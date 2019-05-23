require 'travis/yml/schema/dsl/str'

module Travis
  module Yml
    module Schema
      module Def
        class Conditions < Dsl::Str
          register :conditions

          def define
            summary 'Conditions support version'
            # default :v1
            value :v0
            value :v1
            export
          end
        end

        class Condition < Dsl::Str
          register :condition

          def define
            summary 'Condition to determine whether or not a build, stage, or job should be run'
            export
          end
        end
      end
    end
  end
end
