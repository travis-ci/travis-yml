# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Addon < Type::Map
            registry :addon

            def after_define
              normal
              change :enable
              export
            end
          end
        end

        class Addons < Type::Map
          register :addons

          def define
            summary 'Build addons to activate'

            description <<~str
              Build addons enable additional built-in functionality, such as
              installing build dependencies, system setup tasks, and integrations
              with external services.
            str

            map :apt
            map :apt_packages,    to: :seq
            map :artifacts
            map :browserstack
            map :chrome,          to: :str, values: %i(stable beta)
            map :code_climate
            map :coverity_scan
            map :homebrew
            map :hostname,        to: :str
            map :hosts,           to: :seq
            map :jwt,             to: :jwts
            map :sauce_connect,   to: :sauce_connect
            map :snaps
            map :pkg
            map :sonarcloud
            map :ssh_known_hosts, to: :secures, strict: false

            # turn this into a proper addon definition. the map allows the key debug: true
            map :srcclr, to: Class.new(Type::Any) {
              def define
                type :map,  normal: true, strict: false
                type :bool, normal: true
              end
            }

            map :firefox,         to: :any, type: [:num, :str], eg: '68.0b1'
            map :mariadb,         to: :str
            map :postgresql,      to: :str, alias: :postgres
            map :rethinkdb,       to: :str
            map :deploy,          to: :deploys

            export
          end
        end
      end
    end
  end
end

require 'travis/yml/schema/def/addon/apt'
require 'travis/yml/schema/def/addon/artifacts'
require 'travis/yml/schema/def/addon/browserstack'
require 'travis/yml/schema/def/addon/code_climate'
require 'travis/yml/schema/def/addon/coverity_scan'
require 'travis/yml/schema/def/addon/homebrew'
require 'travis/yml/schema/def/addon/jwts'
require 'travis/yml/schema/def/addon/sauce_connect'
require 'travis/yml/schema/def/addon/snaps'
require 'travis/yml/schema/def/addon/pkg'
require 'travis/yml/schema/def/addon/sonarcloud'
