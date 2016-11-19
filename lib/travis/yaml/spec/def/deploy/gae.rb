module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention config
          # docs do not mention version
          # docs do not mention verbosity
          class Gae < Deploy
            register :gae

            def define
              super
              map :project,                  to: :scalar
              map :keyfile,                  to: :scalar
              map :config,                   to: :scalar
              map :version,                  to: :scalar
              map :no_promote,               to: :scalar, cast: :bool
              map :no_stop_previous_version, to: :scalar, cast: :bool
              map :verbosity,                to: :scalar
            end
          end
        end
      end
    end
  end
end
