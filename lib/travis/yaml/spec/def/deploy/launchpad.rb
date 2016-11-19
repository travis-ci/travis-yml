module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Launchpad < Deploy
            register :launchpad

            def define
              super
              map :slug,               to: :scalar, required: true
              map :oauth_token,        to: :scalar, required: true, cast: :secure
              map :oauth_token_secret, to: :scalar, required: true, cast: :secure
            end
          end
        end
      end
    end
  end
end
