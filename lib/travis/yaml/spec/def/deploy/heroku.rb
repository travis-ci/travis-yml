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
              map :strategy,  to: :heroku_strategy
              map :buildpack, to: :str
              map :app,       to: :str
              map :api_key,   to: :str, secure: true
              map :run,       to: :seq
            end
          end

          class HerokuStrategy < Type::Fixed
            register :heroku_strategy

            DEPRECATED = 'will be removed in v1.1.0'

            def define
              default :api
              value :api
              value :git
              value :'git-ssh', deprecated: DEPRECATED, version: '1.0'
              value :'git-deploy-key', deprecated: DEPRECATED, version: '1.0'
            end
          end
        end
      end
    end
  end
end

