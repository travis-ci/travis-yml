module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Scalingo < Deploy
            register :scalingo

            def define
              super
              map :username, to: :scalar, cast: :secure
              map :password, to: :scalar, cast: :secure
              map :api_key,  to: :scalar, cast: :secure
              map :remote,   to: :scalar
              map :branch,   to: :scalar
              map :app,      to: :scalar
            end
          end
        end
      end
    end
  end
end
