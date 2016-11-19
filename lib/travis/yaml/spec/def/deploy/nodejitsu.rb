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
              map :username, to: :scalar, cast: :secure
              map :api_key,  to: :scalar, cast: :secure
            end
          end
        end
      end
    end
  end
end
