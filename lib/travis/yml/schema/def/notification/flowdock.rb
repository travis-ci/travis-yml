# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Flowdock < Notification
            register :flowdock

            def define
              see 'Configuring Flowdock notifications': 'https://docs.travis-ci.com/user/notifications/#configuring-flowdock-notifications'

              prefix :api_token

              map :api_token, to: :secure, summary: 'Flowdock API token'
              map :template,  to: :templates
            end
          end
        end
      end
    end
  end
end
