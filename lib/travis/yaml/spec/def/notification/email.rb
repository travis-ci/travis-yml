module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Email < Type::Map
            register :email

            def define
              normalize :enabled

              prefix :recipients

              map :enabled,    to: :scalar, cast: :bool, default: true, required: true
              map :recipients, to: :seq
              maps *Notifications::CALLBACKS

              # normalize { |value| Normalize.new(:recipients, value).apply }
            end
          end
        end
      end
    end
  end
end
