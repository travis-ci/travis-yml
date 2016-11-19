module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention debug
          # docs do not mention version
          class Atlas < Deploy
            register :atlas

            def define
              super
              map :token,    to: :scalar, cast: :secure
              map :app,      to: :scalar
              map :exclude,  to: :seq
              map :include,  to: :seq
              map :address , to: :scalar
              map :vcs,      to: :scalar, cast: :bool
              map :metadata, to: :seq
              map :debug,    to: :scalar, cast: :bool
              map :version,  to: :scalar
            end
          end
        end
      end
    end
  end
end
