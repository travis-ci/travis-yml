# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Hackage < Deploy
            register :hackage

            def define
              map :username, to: :secure
              map :password, to: :secure
            end
          end
        end
      end
    end
  end
end
