# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Firebase < Deploy
            register :firebase

            def define
              map :project,  to: :str
              map :token,    to: :secure
              map :message,  to: :str
            end
          end
        end
      end
    end
  end
end
