# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Slack < Notification
            register :slack

            def define
              see 'Configuring Slack notifications': 'https://docs.travis-ci.com/user/notifications/#configuring-slack-notifications'

              prefix :rooms

              map :rooms,    to: :seq, type: :secure, summary: 'Slack channels to notify'
              map :template, to: :templates
              map :on_pull_requests, to: :bool, summary: 'Whether to notify on pull requests'
            end
          end
        end
      end
    end
  end
end
