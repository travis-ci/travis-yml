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
              super
              map :user,              to: :secure
              map :password,          to: :secure
              map :domain,            to: :str
              map :app,               to: :str
              map :deployment_branch, to: :str

              export
            end
          end
        end
      end
    end
  end
end
