module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Modulus < Deploy
            register :modulus

            def define
              super
              map :api_key,      to: :scalar, cast: :secure
              map :project_name, to: :scalar
            end
          end
        end
      end
    end
  end
end
