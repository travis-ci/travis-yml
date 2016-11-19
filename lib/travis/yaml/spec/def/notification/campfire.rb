module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Campfire < Type::Map
            register :campfire

            def define
              prefix :rooms
              normalize :inherit, keys: [:on_success, :on_failure]

              map :rooms,    to: :seq, cast: :secure
              map :template, to: :templates
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end
