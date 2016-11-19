require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/def/addon/apt'
require 'travis/yaml/spec/def/addon/artifacts'
require 'travis/yaml/spec/def/addon/browserstack'
require 'travis/yaml/spec/def/addon/code_climate'
require 'travis/yaml/spec/def/addon/coverity_scan'
require 'travis/yaml/spec/def/addon/jwts'
require 'travis/yaml/spec/def/addon/sauce_connect'

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
            map :deploy,          to: :deploys
            map :hostname,        to: :scalar
            map :hosts,           to: :seq
            map :jwt,             to: :jwts
            map :sauce_connect,   to: :sauce_connect
            map :ssh_known_hosts, to: :seq
            map :sonarqube,       to: :scalar, cast: :bool

            map :firefox,         to: :scalar
            map :mariadb,         to: :scalar
            map :postgresql,      to: :scalar
            map :rethinkdb,       to: :scalar
          end
        end
      end
    end
  end
end
