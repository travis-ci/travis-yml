require 'travis/yml/schema/dsl/enum'

module Travis
  module Yml
    module Schema
      module Def
        class Conditions < Dsl::Enum
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
