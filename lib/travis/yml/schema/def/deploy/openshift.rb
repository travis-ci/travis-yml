# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # dpl readme does not mention deployment_branch
          class Openshift < Deploy
            register :openshift

            def define
              map :user,              to: :secure, strict: false
              map :password,          to: :secure
              map :domain,            to: :map, type: :str
              map :app,               to: :map, type: :str
              map :deployment_branch, to: :str
            end
          end
        end
      end
    end
  end
end
