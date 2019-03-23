# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Firebase < Deploy
            register :firebase

            def define
              super
              map :project,  to: :str
              map :token,    to: :secure
              map :message,  to: :str

              export
            end
          end
        end
      end
    end
  end
end
