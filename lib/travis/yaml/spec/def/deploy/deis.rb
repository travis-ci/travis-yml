module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Deis < Deploy
            register :deis

            def define
              super
              map :controller,  to: :str
              map :username,    to: :str, secure: true
              map :password,    to: :str, secure: true
              map :app,         to: :str
              map :cli_version, to: :str
            end
          end
        end
      end
    end
  end
end
