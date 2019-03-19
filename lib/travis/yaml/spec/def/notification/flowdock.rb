# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Flowdock < Type::Map
            register :flowdock

            def define
              prefix :api_token, type: [:str, :secure]
              change :inherit, keys: Notifications::INHERIT
              change :enable

              map :enabled,   to: :bool
              map :disabled,  to: :bool
              map :api_token, to: :str, secure: true
              map :template,  to: :templates
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end
