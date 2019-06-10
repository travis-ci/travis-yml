# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Heroku < Deploy
            register :heroku

            def define
              map :strategy,  to: :str, default: 'api', values: %w(api git)
              map :api_key,   to: :map, type: :secure
              map :username,  to: :secure, alias: :user
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
