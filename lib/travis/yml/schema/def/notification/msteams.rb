# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Msteams < Notification
            register :msteams

            def define
              see 'Configuring Ms Teams notifications': 'https://docs.travis-ci.com/user/notifications/#configuring-ms-teams-notifications'

              prefix :rooms

              map :rooms,    to: :seq, type: :secure, summary: 'MS Teams webhook URLs'
              map :on_pull_requests, to: :bool, summary: 'Whether to notify on pull requests'
            end
          end
        end
      end
    end
  end
end
