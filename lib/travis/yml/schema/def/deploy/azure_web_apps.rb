# frozen_string_literalexports: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class AzureWebApps < Deploy
            register :azure_web_apps

            def define
              map :site,     to: :str
              map :slot,     to: :str
              map :username, to: :secure
              map :password, to: :secure
              map :verbose,  to: :bool
            end
          end
        end
      end
    end
  end
end
