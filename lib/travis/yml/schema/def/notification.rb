require 'travis/yml/schema/def/notification'
require 'travis/yml/schema/dsl/str'
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
              summary 'Notification targets to notify on build results'

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
              maps *STATUSES, to: :frequency

              change :inherit, keys: STATUSES

              export
            end
          end

          class Notification < Dsl::Map
            registry :notification

            def define
              normal

              map :enabled,  to: :bool
              map :disabled, to: :bool
              maps *STATUSES, to: :frequency

              change :enable
              export
            end
          end

          class Templates < Dsl::Seq
            registry :notification
            register :templates

            def define
              type :template
              export
            end
          end

          class Template < Dsl::Str
            registry :notification
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
              export
            end
          end

          class Frequency < Dsl::Str
            registry :notification
            register :frequency

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
