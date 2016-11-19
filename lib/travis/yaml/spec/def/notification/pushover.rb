module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Pushover < Type::Map
            register :pushover

            def define
              normalize :inherit, keys: [:on_success, :on_failure]

              map :api_key,  to: :scalar, cast: :secure
              map :users,    to: :seq,    cast: :secure
              map :template, to: :templates
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end
