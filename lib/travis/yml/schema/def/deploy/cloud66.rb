# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Cloud66 < Deploy
            register :cloud66

            def define
              map :redeployment_hook, to: :str
            end
          end
        end
      end
    end
  end
end
