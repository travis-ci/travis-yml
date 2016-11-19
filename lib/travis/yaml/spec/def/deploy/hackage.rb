module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Hackage < Deploy
            register :hackage

            def define
              super
              map :username, to: :scalar, cast: :secure
              map :password, to: :scalar, cast: :secure
            end
          end
        end
      end
    end
  end
end
