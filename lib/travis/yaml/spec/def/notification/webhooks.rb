# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Webhooks < Type::Map
            register :webhooks

            def define
              prefix :urls, type: [:str, :secure, :seq]
              change :inherit, keys: Notifications::INHERIT
              change :enable

              map :enabled,  to: :bool
              map :disabled, to: :bool
              map :urls,     to: :seq
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end
