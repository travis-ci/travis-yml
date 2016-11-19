module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Irc < Type::Map
            register :irc

            def define
              prefix :channels
              normalize :inherit, keys: [:on_success, :on_failure]

              map :channels,          to: :seq,    cast: :secure
              map :channel_key,       to: :scalar, cast: :secure
              map :password,          to: :scalar, cast: :secure
              map :nickserv_password, to: :scalar, cast: :secure
              map :nick,              to: :scalar, cast: :secure
              map :use_notice,        to: :scalar, cast: :bool
              map :skip_join,         to: :scalar, cast: :bool
              map :template,          to: :templates
              maps *Notifications::CALLBACKS

              # normalize { |value| Normalize.new(:channels, value).apply }
            end
          end
        end
      end
    end
  end
end
