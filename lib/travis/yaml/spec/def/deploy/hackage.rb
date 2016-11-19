module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Hackage < Deploy
            register :hackage

            def define
              super
              map :username, to: :str, secure: true
              map :password, to: :str, secure: true
            end
          end
        end
      end
    end
  end
end
