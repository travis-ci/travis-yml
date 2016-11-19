module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class AzureWebApps < Deploy
            register :azure_web_apps

            def define
              super
              map :site,     to: :str
              map :slot,     to: :str
              map :username, to: :str, secure: true
              map :password, to: :str, secure: true
              map :verbose,  to: :bool
            end
          end
        end
      end
    end
  end
end
