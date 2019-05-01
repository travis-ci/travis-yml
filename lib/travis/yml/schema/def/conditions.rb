require 'travis/yml/schema/dsl/str'

module Travis
  module Yml
    module Schema
      module Def
        class Conditions < Dsl::Str
          register :conditions

          def define
            # default :v1
            value :v0
            value :v1
            export
          end
        end
      end
    end
  end
end
