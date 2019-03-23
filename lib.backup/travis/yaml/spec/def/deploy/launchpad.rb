# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Launchpad < Deploy
            register :launchpad

            def define
              super
              map :slug,               to: :str, required: true
              map :oauth_token,        to: :str, required: true, secure: true
              map :oauth_token_secret, to: :str, required: true, secure: true
            end
          end
        end
      end
    end
  end
end
