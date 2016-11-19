module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Webhooks < Type::Map
            register :webhooks

            def define
              prefix :urls
              normalize :inherit, keys: [:on_start, :on_success, :on_failure]

              map :urls, to: :seq
              map :on_start, to: :callback
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end
