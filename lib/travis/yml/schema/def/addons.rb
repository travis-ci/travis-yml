# frozen_string_literal: true
require 'travis/yml/schema/def/addon'
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        class Addons < Dsl::Map
          register :addons

          def define
            map :apt,             to: :apt
            map :apt_packages,    to: :seq
            map :browserstack,    to: :browserstack
            map :artifacts,       to: :artifacts
            map :code_climate,    to: :code_climate
            map :coverity_scan,   to: :coverity_scan
            map :homebrew,        to: :homebrew
            map :hostname,        to: :str
            map :hosts,           to: :seq
            map :jwt,             to: :jwts
            map :sauce_connect,   to: :sauce_connect
            map :snaps,           to: :snaps
            map :ssh_known_hosts, to: :seq

            type = Class.new(Dsl::Any) do
              def define
                add :map,  normal: true, strict: false
                add :bool, normal: true
              end
            end

            map :sonarqube,       to: type
            map :srcclr,          to: type
            map :firefox,         to: :str
            map :mariadb,         to: :str
            map :postgresql,      to: :str, alias: :postgres
            map :rethinkdb,       to: :str
            map :deploy,          to: :deploys

            change :enable

            export
          end
        end
      end
    end
  end
end
