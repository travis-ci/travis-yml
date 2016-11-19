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
          CALLBACKS = [:on_success, :on_failure, to: :callback]

          register :notifications

          def define
            map :email,    to: :email
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
              repository repository_slug repository_name build_number build_id
              pull_request pull_request_number branch commit author
              commit_subject commit_message result duration message compare_url
              build_url pull_request_url
            )

            def define
              validate :template, vars: VARS
            end
          end

          class Callback < Type::Fixed
            register :callback

            def define
              value :always
              value :never
              value :change
            end
          end
        end
      end
    end
  end
end
