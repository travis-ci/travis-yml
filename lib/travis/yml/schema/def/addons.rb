# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Addon < Dsl::Map
            registry :addon

            def define
              normal
              change :enable
              export
            end
          end
        end

        class Addons < Dsl::Map
          register :addons

          def define
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
            map :ssh_known_hosts, to: :seq, type: :secure
            map :sonarcloud

            # turn this into a proper addon definition. the map allows the key debug: true
            type = Class.new(Dsl::Any) do
              def define
                add :map,  normal: true, strict: false
                add :bool, normal: true
              end
            end

            map :srcclr,          to: type
            map :firefox,         to: :any, type: [:num, :str]
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
require 'travis/yml/schema/def/addon/sonarcloud'
