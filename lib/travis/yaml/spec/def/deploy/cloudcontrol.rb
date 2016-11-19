module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Cloudcontrol < Deploy
            register :cloudcontrol

            def define
              super
              map :email,      to: :str, secure: true
              map :password,   to: :str, secure: true
              map :deployment, to: :str
            end
          end
        end
      end
    end
  end
end
