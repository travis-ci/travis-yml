# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Openshift < Deploy
            register :openshift

            def define
              map :token,    to: :secure
              map :user,     to: :secure, strict: false
              map :password, to: :secure
              map :server,   to: :str
              map :project,  to: :str
              map :app,      to: :str
            end
          end
        end
      end
    end
  end
end
