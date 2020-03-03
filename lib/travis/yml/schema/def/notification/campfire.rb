# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Campfire < Notification
            register :campfire

            def define
              see 'Configuring Campfire notifications': 'https://docs.travis-ci.com/user/notifications/#configuring-campfire-notifications'

              prefix :rooms

              map :rooms,    to: :seq, type: :secure, summary: 'Campfire rooms to notify'
              map :template, to: :templates
            end
          end
        end
      end
    end
  end
end
