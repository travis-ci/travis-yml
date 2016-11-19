module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Npm < Deploy
            register :npm

            def define
              super
              map :email,   to: :scalar, cast: :secure
              map :api_key, to: :scalar, cast: :secure
            end
          end
        end
      end
    end
  end
end
