# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # dpl readme says it's api-key, our docs say it's api_key
          class Heroku < Deploy
            register :heroku

            def define
              map :strategy,  to: :str, default: 'api', values: %w(api git)
              map :api_key,   to: :map, type: :secure
              map :username,  to: :secure
              map :password,  to: :secure
              map :app,       to: :map, type: :str
              map :git,       to: :str
            end
          end
        end
      end
    end
  end
end
