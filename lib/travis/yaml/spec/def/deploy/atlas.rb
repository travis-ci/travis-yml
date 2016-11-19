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
              map :token,    to: :str, secure: true
              map :app,      to: :str
              map :exclude,  to: :seq
              map :include,  to: :seq
              map :address , to: :str
              map :vcs,      to: :bool
              map :metadata, to: :seq
              map :debug,    to: :bool
              map :version,  to: :str
            end
          end
        end
      end
    end
  end
end
