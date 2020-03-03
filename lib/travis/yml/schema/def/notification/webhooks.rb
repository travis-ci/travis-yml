# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Webhooks < Notification
            register :webhooks

            def define
              see 'Configuring Webhook notifications': 'https://docs.travis-ci.com/user/notifications/#configuring-webhook-notifications'

              aliases :webhook
              prefix :urls

              map :urls,      to: :webhook_urls, summary: 'Webhook URLs to notify'
              map :on_start,  to: :frequency
              map :on_cancel, to: :frequency
              map :on_error,  to: :frequency
            end
          end

          class WebhookUrls < Type::Seq
            register :webhook_urls

            def define
              type :secure, strict: false
            end
          end
        end
      end
    end
  end
end
