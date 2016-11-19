module Travis
  module Yaml
    module Spec
      module Def
        module Notification
          class Irc < Type::Map
            register :irc

            def define
              prefix :channels, type: [:str, :secure, :seq]
              change :inherit, keys: Notifications::INHERIT
              change :enable

              map :enabled,           to: :bool
              map :disabled,          to: :bool
              map :channels,          to: :seq, secure: true
              map :channel_key,       to: :str, secure: true
              map :password,          to: :str, secure: true
              map :nickserv_password, to: :str, secure: true
              map :nick,              to: :str
              map :use_notice,        to: :bool
              map :skip_join,         to: :bool
              map :template,          to: :templates
              maps *Notifications::CALLBACKS
            end
          end
        end
      end
    end
  end
end
