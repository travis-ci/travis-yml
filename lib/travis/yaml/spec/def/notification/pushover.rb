# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Pushover < Type::Map
            register :pushover

            def define
              change :inherit, keys: Notifications::INHERIT
              change :enable

              map :enabled,  to: :bool
              map :disabled, to: :bool
              map :api_key,  to: :str, secure: true
              map :users,    to: :seq, secure: true
              map :template, to: :templates
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end
