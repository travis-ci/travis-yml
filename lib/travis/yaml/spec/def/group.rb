require 'travis/yaml/spec/type/fixed'

module Travis
  module Yaml
    module Spec
      module Def
        class Group < Type::Scalar
          register :group

          def define
            default :stable
            downcase
          end
        end
      end
    end
  end
end
