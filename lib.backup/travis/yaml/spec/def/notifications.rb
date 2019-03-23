# frozen_string_literal: true
require 'travis/yaml/spec/def/notification/campfire'
require 'travis/yaml/spec/def/notification/email'
require 'travis/yaml/spec/def/notification/flowdock'
require 'travis/yaml/spec/def/notification/hipchat'
require 'travis/yaml/spec/def/notification/irc'
require 'travis/yaml/spec/def/notification/pushover'
require 'travis/yaml/spec/def/notification/slack'
require 'travis/yaml/spec/def/notification/webhooks'
require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Notifications < Type::Map
          CALLBACKS = [:on_start, :on_success, :on_failure, to: :callback]
          INHERIT   = [:disabled, :on_start, :on_success, :on_failure]

          register :notifications

          def define
            prefix :email, type: :bool
            map :enabled,  to: :bool
            map :disabled, to: :bool
            map :email,    to: :email, alias: :emails
            map :campfire, to: :campfire
            map :flowdock, to: :flowdock
            map :hipchat,  to: :hipchat
            map :irc,      to: :irc
            map :pushover, to: :pushover
            map :slack,    to: :slack
            map :webhooks, to: :webhooks, alias: :webhook
            maps *CALLBACKS
          end

          class Templates < Type::Seq
            register :templates

            def define
              type :template
            end
          end

          class Template < Type::Scalar
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
              validate :template, vars: VARS
            end
          end

          class Callback < Type::Fixed
            register :callback

            def define
              value :always, alias: 'true'
              value :never,  alias: 'false'
              value :change, alias: 'changed'
            end
          end
        end
      end
    end
  end
end
