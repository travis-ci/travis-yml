module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # dpl readme does not mention image
          # dpl readme does not mention extra_args
          class Boxfuse < Deploy
            register :boxfuse

            def define
              super
              map :user,       to: :scalar, cast: :secure
              map :secret,     to: :scalar, cast: :secure
              map :configfile, to: :scalar
              map :payload,    to: :scalar
              map :app,        to: :scalar
              map :version,    to: :scalar
              map :env,        to: :scalar
              map :image,      to: :scalar
              map :extra_args, to: :scalar
            end
          end
        end
      end
    end
  end
end
