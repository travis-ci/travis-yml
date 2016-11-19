module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # https://github.com/travis-ci/dpl#heroku
          # dpl readme says it's api-key, our docs say it's api_key
          # dpl readme does not mention the buildpack
          class Heroku < Deploy
            register :heroku

            def define
              super
              map :strategy,  to: :scalar
              map :buildpack, to: :scalar
              map :app,       to: [:scalar, :deploy_branches]
              map :api_key,   to: [:scalar, :map], cast: :secure, alias: :'api-key'
              map :run,       to: :seq
            end
          end
        end
      end
    end
  end
end
