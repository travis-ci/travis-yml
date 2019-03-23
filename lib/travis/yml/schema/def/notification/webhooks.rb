# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Webhooks < Notification
            register :webhooks

            def define
              aliases :webhook
              prefix :urls

              map :urls,     to: :seq, type: :secure
              map :on_start, to: :notification_frequency

              super
            end
          end
        end
      end
    end
  end
end
