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
              see 'Configuring IRC notifications': 'https://docs.travis-ci.com/user/notifications/#configuring-irc-notifications'

              prefix :channels

              map :channels,          to: :irc_channels, summary: 'IRC channels to notify'
              map :channel_key,       to: :secure, summary: 'IRC channel key (password)'
              map :password,          to: :secure, summary: 'IRC user password'
              map :nickserv_password, to: :secure, summary: 'IRC nickserv password'
              map :nick,              to: :secure, strict: false, summary: 'IRC Nick name'
              map :use_notice,        to: :bool, summary: 'Whether to use notices instead of regular messages'
              map :skip_join,         to: :bool, summary: 'Whether to skip joining the channel'
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
