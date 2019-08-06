# frozen_string_literal: true
# according to the docs it's user: https://docs.travis-ci.com/user/deployment/scalingo/#connecting-using-a-username-and-password
# according to dpl it's username: https://github.com/travis-ci/dpl#scalingo
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Scalingo < Deploy
            register :scalingo

            def define
              map :api_token, to: :secure, alias: :api_key
              map :username,  to: :secure, strict: false, alias: :user
              map :password,  to: :secure
              map :remote,    to: :str
              map :branch,    to: :str
              map :app,       to: :str
              map :region,    to: :str
              map :timeout,   to: :num
            end
          end
        end
      end
    end
  end
end
