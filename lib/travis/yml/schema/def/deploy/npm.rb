# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Npm < Deploy
            register :npm

            def define
              map :email,       to: :secure, strict: false
              map :api_token,   to: :secure, alias: :api_key
              map :access,      to: :str, enum: %w(public private)
              map :registry,    to: :str
              map :src,         to: :str
              map :tag,         to: :str
              map :auth_method, to: :str
            end
          end
        end
      end
    end
  end
end
