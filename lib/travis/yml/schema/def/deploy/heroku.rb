# frozen_string_literal: true
module Travis
  module Yml
    module Schema
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
              map :app,       to: :app
              map :api_key,   to: :secure
              map :run,       to: :seq

              export
            end
          end

          class HerokuStrategy < Dsl::Enum
            register :heroku_strategy

            def define
              default :api
              value :api
              value :git
            end
          end
        end
      end
    end
  end
end

