require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          STATUSES = %i(on_success on_failure)

          class Notifications < Type::Map
            register :notifications

            def define
              summary 'Notification targets to notify on build results'

              normal
              prefix :email

              map :campfire, to: :seq, type: :campfire, summary: 'Campfire notification settings'
              map :email,    to: :seq, type: :email, summary: 'Email notification settings'
              map :flowdock, to: :seq, type: :flowdock, summary: 'Flowdock notification settings'
              map :hipchat,  to: :seq, type: :hipchat, summary: 'Hipchat notification settings'
              map :irc,      to: :seq, type: :irc, summary: 'IRC notification settings'
              map :pushover, to: :seq, type: :pushover, summary: 'Pushover notification settings'
              map :slack,    to: :seq, type: :slack, summary: 'Slack notification settings'
              map :webhooks, to: :seq, type: :webhooks, summary: 'Webhook notification settings'
              map :msteams,  to: :seq, type: :msteams, summary: 'MS Teams notification settings'
              maps *STATUSES, to: :frequency

              change :inherit, keys: STATUSES

              export
            end
          end

          class Notification < Type::Map
            registry :notification

            def after_define
              normal

              map :if, to: :condition
              maps *STATUSES, to: :frequency
              map :enabled,  to: :bool, summary: 'Whether to enable these notifications'
              map :disabled, to: :bool, summary: 'Whether to disable these notifications'

              change :enable
              export
            end
          end

          class Templates < Type::Seq
            registry :notification
            register :templates

            def define
              summary 'Templates to use for the notification message'
              type :template
              export
            end
          end

          class Template < Type::Str
            registry :notification
            register :template

            def define
              vars *%w(
                repository
                repository_slug
                repository_name
                build_number
                build_id
                build_url
                branch
                commit
                commit_subject
                commit_message
                author
                pull_request
                pull_request_number
                pull_request_url
                compare_url
                result
                duration
                elapsed_time
                message
              )

              export
            end
          end

          class Frequency < Type::Str
            registry :notification
            register :frequency

            def define
              summary 'Notification frequency'
              value :always, alias: 'true'
              value :never,  alias: 'false'
              value :change, alias: 'changed'

              export
            end
          end
        end
      end
    end
  end
end

require 'travis/yml/schema/def/notification/campfire'
require 'travis/yml/schema/def/notification/email'
require 'travis/yml/schema/def/notification/flowdock'
require 'travis/yml/schema/def/notification/hipchat'
require 'travis/yml/schema/def/notification/irc'
require 'travis/yml/schema/def/notification/pushover'
require 'travis/yml/schema/def/notification/slack'
require 'travis/yml/schema/def/notification/msteams'
require 'travis/yml/schema/def/notification/webhooks'
