# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Npm < Deploy
            register :npm

            def define
              map :registry,  to: :str
              map :api_token, to: :secure, alias: :api_key
              map :email,     to: :secure, strict: false
              map :access,    to: :str, enum: %w(public private)
              map :tag,       to: :str
            end
          end
        end
      end
    end
  end
end
