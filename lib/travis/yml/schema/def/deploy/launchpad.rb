# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Launchpad < Deploy
            register :launchpad

            def define
              super
              map :slug,               to: :str, required: true
              map :oauth_token,        to: :secure, required: true
              map :oauth_token_secret, to: :secure, required: true

              export
            end
          end
        end
      end
    end
  end
end
