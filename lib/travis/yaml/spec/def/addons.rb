require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/def/addon/apt'
require 'travis/yaml/spec/def/addon/artifacts'
require 'travis/yaml/spec/def/addon/browserstack'
require 'travis/yaml/spec/def/addon/code_climate'
require 'travis/yaml/spec/def/addon/coverity_scan'
require 'travis/yaml/spec/def/addon/homebrew'
require 'travis/yaml/spec/def/addon/jwts'
require 'travis/yaml/spec/def/addon/sauce_connect'
require 'travis/yaml/spec/def/addon/snaps'

module Travis
  module Yaml
    module Spec
      module Def
        class Addons < Type::Map
          register :addons

          def define
            strict true

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
            map :sonarqube,       to: [:map, :bool]
            map :srcclr,          to: [:map, :bool]

            map :firefox,         to: :str
            map :mariadb,         to: :str
            map :postgresql,      to: :str
            map :rethinkdb,       to: :str

            map :deploy,          to: :deploys
          end
        end
      end
    end
  end
end
