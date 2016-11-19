module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Slack < Type::Map
            register :slack

            def define
              prefix :rooms
              normalize :inherit, keys: [:on_success, :on_failure]

              map :rooms,            to: :seq, cast: :secure
              map :template,         to: :templates
              map :on_pull_requests, to: :scalar, cast: :bool
              maps *Notifications::CALLBACKS

              # normalize { |value| Normalize.new(:rooms, value).apply }
            end
          end
        end
      end
    end
  end
end

