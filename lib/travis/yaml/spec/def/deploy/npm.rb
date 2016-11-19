module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Npm < Deploy
            register :npm

            def define
              super
              map :email,   to: :str, secure: true
              map :api_key, to: :str, secure: true
            end
          end
        end
      end
    end
  end
end
