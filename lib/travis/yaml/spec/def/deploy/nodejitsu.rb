module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # not mentioned on our docs at all
          class Nodejitsu < Deploy
            register :nodejitsu

            def define
              super
              map :username, to: :str, secure: true
              map :api_key,  to: :str, secure: true
            end
          end
        end
      end
    end
  end
end
