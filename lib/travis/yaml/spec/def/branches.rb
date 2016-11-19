require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class BranchConditions < Type::Map
          register :branch_conditions

          def define
            map :only,   to: :branches
            map :except, to: :branches
            prefix :only
          end

          class Branches < Type::Seq
            register :branches

            def define
              type :branch
            end
          end

          class Branch < Type::Scalar
            register :branch

            def define
              cast :str, :regex
            end
          end
        end
      end
    end
  end
end
