module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Exoscale < Deploy
            register :exoscale

            def define
              super
              map :email,      to: :scalar, cast: :secure
              map :password,   to: :scalar, cast: :secure
              map :deployment, to: :scalar
            end
          end
        end
      end
    end
  end
end
