module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Hipchat < Type::Map
            register :hipchat

            def define
              prefix :rooms
              normalize :inherit, keys: [:on_success, :on_failure]

              map :rooms,            to: :seq, cast: :secure
              map :format,           to: :fixed, values: [:html, :text]
              map :notify,           to: :scalar, cast: :bool
              map :on_pull_requests, to: :scalar, cast: :bool
              map :template,         to: :templates
              maps *Notifications::CALLBACKS

              # normalize { |value| Normalize.new(:rooms, value).apply }
            end
          end
        end
      end
    end
  end
end
