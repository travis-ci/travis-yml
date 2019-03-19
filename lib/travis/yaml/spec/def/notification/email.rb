# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Email < Type::Map
            register :email

            def define
              prefix :recipients, type: [:str, :secure, :seq]
              change :inherit, keys: Notifications::INHERIT
              change :enable

              map :enabled,    to: :bool
              map :disabled,   to: :bool
              map :recipients, to: :seq
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end
