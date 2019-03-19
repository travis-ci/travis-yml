# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Firebase < Deploy
            register :firebase

            def define
              super
              map :project,  to: :str
              map :token,    to: :str, secure: true
              map :message,  to: :str
            end
          end
        end
      end
    end
  end
end
