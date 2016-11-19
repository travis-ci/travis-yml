module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Anynines < Deploy
            register :anynines

            def define
              super
              map :username,     to: :scalar, cast: :secure
              map :password,     to: :scalar, cast: :secure
              map :organization, to: :scalar
              map :space,        to: :scalar
            end
          end
        end
      end
    end
  end
end
