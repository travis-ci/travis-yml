require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Env < Type::Map
          register :env

          def define
            map :global, to: :env_vars
            map :matrix, to: :env_vars

            prefix :matrix
          end

          class Vars < Type::Seq
            register :env_vars

            def define
              normalize :vars
              type :env_var
            end
          end

          class Var < Type::Scalar
            register :env_var

            def define
              cast :str, :secure
            end
          end
        end
      end
    end
  end
end
