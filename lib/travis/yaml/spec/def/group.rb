require 'travis/yaml/spec/type/fixed'

module Travis
  module Yaml
    module Spec
      module Def
        class Group < Type::Fixed
          register :group

          def define
            default :stable
            downcase
            flagged

            value :stable
            value :edge
          end
        end
      end
    end
  end
end
