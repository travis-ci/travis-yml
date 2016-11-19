require 'travis/yaml/spec/type/scalar'

module Travis
  module Yaml
    module Spec
      module Def
        class Sudo < Type::Scalar
          register :sudo

          def define
            normalize :required
            required
            default false
            cast :bool
          end
        end
      end
    end
  end
end
