module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # dpl readme does not mention deployment_branch
          class Openshift < Deploy
            register :openshift

            def define
              super
              map :user,              to: :scalar, cast: :secure
              map :password,          to: :scalar, cast: :secure
              map :domain,            to: [:scalar, :map]
              map :app,               to: [:scalar, :map]
              map :deployment_branch, to: :scalar
            end
          end
        end
      end
    end
  end
end
