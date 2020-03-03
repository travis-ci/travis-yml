# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Hipchat < Notification
            register :hipchat

            def define
              see 'Configuring Hipchat notifications': 'https://docs.travis-ci.com/user/notifications/#configuring-hipchat-notifications'

              prefix :rooms

              map :rooms,            to: :seq, type: :secure, summary: 'Hipchat rooms to notify (needs to include the API token)'
              map :format,           to: :str, values: [:html, :text], summary: 'Format to use for the notication'
              map :notify,           to: :bool, summary: 'Whether to trigger a user notification (using v2)'
              map :on_pull_requests, to: :bool, summary: 'Whether to notify on pull requests'
              map :template,         to: :templates
            end
          end
        end
      end
    end
  end
end
