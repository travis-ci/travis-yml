require 'travis/yaml/spec/def/addons'
require 'travis/yaml/spec/def/cache'
require 'travis/yaml/spec/def/deploys'
require 'travis/yaml/spec/def/deploy'
require 'travis/yaml/spec/def/git'
require 'travis/yaml/spec/def/group'
require 'travis/yaml/spec/def/jdks'
require 'travis/yaml/spec/def/services'
require 'travis/yaml/spec/type/map'

module Travis
  module Yaml
    module Spec
      module Def
        class Job < Type::Map
          def define
            map :group
            map :osx_image,  to: :str, edge: true, only: { os: :osx }
            map :services
            map :addons
            map :branches,   alias: :branch
            map :cache
            map :deploy,     to: :deploys
            map :git
            map :source_key, to: :str, secure: true
            map :stage,      to: :str
            map :if,         to: :str

            map :before_install, to: :seq
            map :install,        to: :seq
            map :after_install,  to: :seq
            map :before_script,  to: :seq
            map :script,         to: :seq
            map :after_script,   to: :seq
            map :after_result,   to: :seq
            map :after_success,  to: :seq, alias: :on_success
            map :after_failure,  to: :seq, alias: :on_failure
            map :before_deploy,  to: :seq
            map :after_deploy,   to: :seq
            map :before_cache,   to: :seq
          end
        end
      end
    end
  end
end
