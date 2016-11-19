module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # dpl readme says it's api-key, our docs say it's api_key
          class Engineyard < Deploy
            register :engineyard

            def define
              super
              map :username,    to: :str, secure: true
              map :password,    to: :str, secure: true
              map :api_key,     to: :str, secure: true
              map :app,         to: :str
              # TODO where is this env evaluated?
              map :environment, to: :str
              map :migrate,     to: :str
            end
          end
        end
      end
    end
  end
end
