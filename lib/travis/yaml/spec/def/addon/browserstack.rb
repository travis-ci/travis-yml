module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Browserstack < Type::Map
            register :browserstack

            def define
              map :username,     to: :scalar, cast: [:str]
              map :access_key,   to: :scalar, cast: :secure
              map :forcelocal,   to: :scalar, cast: [:bool]
              map :only,         to: :scalar
              # ugh, mixing snakecase and camelcase?
              map :proxyHost,    to: :scalar
              map :proxyPort,    to: :scalar
              map :proxyUser,    to: :scalar
              map :proxyPass,    to: :scalar, cast: :secure
            end
          end
        end
      end
    end
  end
end
