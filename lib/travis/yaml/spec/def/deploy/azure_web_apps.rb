module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class AzureWebApps < Deploy
            register :azure_web_apps

            def define
              super
              map :site,     to: :scalar
              map :slot,     to: :scalar
              map :username, to: :scalar, cast: :secure
              map :password, to: :scalar, cast: :secure
              map :verbose,  to: :scalar, cast: :bool
            end
          end
        end
      end
    end
  end
end
