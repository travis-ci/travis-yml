# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Cloud66 < Deploy
            register :cloud66

            def define
              super
              map :redeployment_hook, to: :str
            end
          end
        end
      end
    end
  end
end
