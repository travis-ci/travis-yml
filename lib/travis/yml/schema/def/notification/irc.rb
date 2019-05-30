# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Irc < Notification
            register :irc

            def define
              title 'IRC'

              prefix :channels

              map :channels,          to: :irc_channels
              map :channel_key,       to: :secure
              map :password,          to: :secure
              map :nickserv_password, to: :secure
              map :nick,              to: :secure
              map :use_notice,        to: :bool
              map :skip_join,         to: :bool
              map :template,          to: :templates
            end
          end

          class IrcChannels < Type::Seq
            register :irc_channels

            def define
              aliases :channel
              type :secure, strict: false
            end
          end
        end
      end
    end
  end
end
