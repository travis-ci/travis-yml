module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Slack < Type::Map
            register :slack

            def define
              prefix :rooms, type: [:str, :secure, :seq]
              change :inherit, keys: Notifications::INHERIT
              change :enable

              map :enabled,          to: :bool
              map :disabled,         to: :bool
              map :rooms,            to: :seq, secure: true
              map :template,         to: :templates
              map :on_pull_requests, to: :bool
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end

