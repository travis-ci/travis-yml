module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Divshot < Deploy
            register :divshot

            def define
              super
              map :api_key,     to: :scalar, cast: :secure
              map :environment, to: :scalar
            end
          end
        end
      end
    end
  end
end
