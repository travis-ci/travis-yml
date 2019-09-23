# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Pushover < Notification
            register :pushover

            def define
              see 'Configuring Pushover notifications': 'https://docs.travis-ci.com/user/notifications/#configuring-pushover-notifications'

              map :api_key,  to: :seq, type: :secure, summary: 'Pushover API key'
              map :users,    to: :seq, type: :secure, summary: 'Pushover users'
              map :template, to: :templates
            end
          end
        end
      end
    end
  end
end
