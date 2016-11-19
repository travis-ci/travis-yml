module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Flowdock < Type::Map
            register :flowdock

            def define
              prefix :api_token
              normalize :inherit, keys: [:on_success, :on_failure]

              map :api_token, to: :scalar, cast: :secure
              map :template,  to: :templates
              maps *Notifications::CALLBACKS

              # normalize { |value| Normalize.new(:api_token, value, :str).apply }
            end
          end
        end
      end
    end
  end
end
