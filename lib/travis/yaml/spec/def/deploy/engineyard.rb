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
              map :username,    to: :scalar, cast: :secure
              map :password,    to: :scalar, cast: :secure
              map :api_key,     to: :scalar, cast: :secure, alias: :'api-key'
              map :app,         to: [:scalar, :map]
              map :environment, to: :map, strict: false
              map :migrate,     to: :scalar
            end
          end
        end
      end
    end
  end
end
