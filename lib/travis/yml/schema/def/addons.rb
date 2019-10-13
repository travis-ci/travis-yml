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
            map :apt_packages,    to: :seq, summary: 'APT package names to install'
            map :artifacts
            map :browserstack
            map :chrome,          to: :str, values: %i(stable beta), downcase: true, summary: 'Chrome version to use'
            map :code_climate
            map :coverity_scan
            map :homebrew
            map :hostname,        to: :str, summary: 'Hostname to set on the build environment'
            map :hosts,           to: :seq, summary: 'Hosts to add to /etc/hosts'
            map :jwt,             to: :jwts
            map :sauce_connect

            # turn this into a proper addon definition. the map allows the key debug: true
            map :srcclr, to: Class.new(Type::Any) {
              def define
                summary 'SourceClear settings'
                type :map,  normal: true, strict: false
                type :bool, normal: true
              end
            }

            map :snaps
            map :sonarcloud
            map :ssh_known_hosts, to: :secures, strict: false, summary: 'Hosts to add to ~/.ssh/known_hosts', see: { 'Adding to SSH Known Hosts': 'https://docs.travis-ci.com/user/ssh-known-hosts/' }

            map :firefox,         to: :any, type: [:num, :str], eg: '68.0b1', summary: 'Firefox version to use'
            map :mariadb,         to: :str, summary: 'MariaDB version to use'
            map :postgresql,      to: :str, alias: :postgres, summary: 'Postgres version to use'
            map :rethinkdb,       to: :str, summary: 'RethinkDB version to use'
            map :deploy,          to: :deploys, internal: true

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
require 'travis/yml/schema/def/addon/sonarcloud'
