require 'travis/yaml/spec/type/scalar'

module Travis
  module Yaml
    module Spec
      module Def
        class Sudo < Type::Scalar
          register :sudo

          def define
            default false
            cast :bool
          end
        end
      end
    end
  end
end
