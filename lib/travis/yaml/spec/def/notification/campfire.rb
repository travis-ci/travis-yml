# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Campfire < Type::Map
            register :campfire

            def define
              prefix :rooms, type: [:str, :secure, :seq]
              change :inherit, keys: Notifications::INHERIT
              change :enable

              map :enabled,  to: :bool
              map :disabled, to: :bool
              map :rooms,    to: :seq, secure: true
              map :template, to: :templates
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end
