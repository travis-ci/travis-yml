# frozen_string_literal: true
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
              map :user,              to: :str, secure: true
              map :password,          to: :str, secure: true
              map :domain,            to: :scalar
              map :app,               to: :scalar
              map :deployment_branch, to: :str
            end
          end
        end
      end
    end
  end
end
