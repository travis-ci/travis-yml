require 'travis/yml/schema/def/notification'
require 'travis/yml/schema/dsl/enum'
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          STATUSES = %i(on_success on_failure)

          class Notifications < Dsl::Map
            register :notifications

            def define
              normal
              prefix :email

              map :campfire, to: :campfire
              map :email,    to: :email, alias: :emails
              map :flowdock, to: :flowdock
              map :hipchat,  to: :hipchat
              map :irc,      to: :irc
              map :pushover, to: :pushover
              map :slack,    to: :slack
              map :webhooks, to: :webhooks
              maps *STATUSES, to: :notification_frequency

              change :enable
              change :inherit, keys: STATUSES

              export
            end
          end

          class Notification < Dsl::Map
            def define
              namespace :notification
              normal

              map :enabled,  to: :bool
              map :disabled, to: :bool
              maps *STATUSES, to: :notification_frequency

              export
            end
          end

          class Templates < Dsl::Seq
            register :templates

            def define
              type :template
            end
          end

          class Template < Dsl::Str
            register :template

            VARS = %w(
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

            def define
              vars *VARS
            end
          end

          class Frequency < Dsl::Enum
            register :notification_frequency

            def define
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
require 'travis/yml/schema/def/notification/webhooks'
