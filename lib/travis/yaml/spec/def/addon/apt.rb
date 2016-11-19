module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Apt < Type::Map
            register :apt

            def define
              map :sources,  to: :seq
              map :packages, to: :seq
            end
          end
        end
      end
    end
  end
end
