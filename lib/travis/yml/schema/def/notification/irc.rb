# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

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

              map :channels,          to: :seq, type: :secure
              map :channel_key,       to: :secure
              map :password,          to: :secure
              map :nickserv_password, to: :secure
              map :nick,              to: :secure
              map :use_notice,        to: :bool
              map :skip_join,         to: :bool
              map :template,          to: :templates

              super
            end
          end
        end
      end
    end
  end
end
