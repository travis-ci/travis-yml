module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Hipchat < Type::Map
            register :hipchat

            def define
              prefix :rooms, type: [:str, :secure, :seq]
              change :inherit, keys: Notifications::INHERIT
              change :enable

              map :enabled,          to: :bool
              map :disabled,         to: :bool
              map :rooms,            to: :seq, secure: true
              map :format,           to: :fixed, values: [:html, :text]
              map :notify,           to: :bool
              map :on_pull_requests, to: :bool
              map :template,         to: :templates
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end
