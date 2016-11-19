module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Cloudcontrol < Deploy
            register :cloudcontrol

            def define
              super
              map :email,      to: :scalar, cast: :secure
              map :password,   to: :scalar, cast: :secure
              map :deployment, to: :scalar
            end
          end
        end
      end
    end
  end
end
