# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Hackage < Deploy
            register :hackage

            def define
              map :username, to: :secure, strict: false
              map :password, to: :secure
              map :publish,  to: :bool
            end
          end
        end
      end
    end
  end
end
