module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Deis < Deploy
            register :deis

            def define
              super
              map :controller,  to: :scalar
              map :username,    to: :scalar, cast: :secure
              map :password,    to: :scalar, cast: :secure
              map :app,         to: :scalar
              map :cli_version, to: :scalar
            end
          end
        end
      end
    end
  end
end
