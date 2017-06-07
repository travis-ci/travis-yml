module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Firebase < Deploy
            register :firebase

            def define
              super
              map :project,  to: :str
              map :message,  to: :str
              map :token,    to: :str, secure: true
            end
          end
        end
      end
    end
  end
end
