# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Scalingo < Deploy
            register :scalingo

            def define
              map :username, to: :secure
              map :password, to: :secure
              map :api_key,  to: :secure
              map :remote,   to: :str
              map :branch,   to: :str
              map :app,      to: :str
            end
          end
        end
      end
    end
  end
end
