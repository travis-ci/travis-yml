require 'travis/yaml/spec/def/addons'
require 'travis/yaml/spec/def/branches'
require 'travis/yaml/spec/def/cache'
require 'travis/yaml/spec/def/deploy'
require 'travis/yaml/spec/def/deploys'
require 'travis/yaml/spec/def/dist'
require 'travis/yaml/spec/def/env'
require 'travis/yaml/spec/def/git'
require 'travis/yaml/spec/def/group'
require 'travis/yaml/spec/def/jdks'
require 'travis/yaml/spec/def/language'
require 'travis/yaml/spec/def/matrix'
require 'travis/yaml/spec/def/notifications'
require 'travis/yaml/spec/def/os'
require 'travis/yaml/spec/def/root'
require 'travis/yaml/spec/def/services'
require 'travis/yaml/spec/def/sudo'
require 'travis/yaml/spec/type/map'

module Travis
  module Yaml
    module Spec
      module Def
        class Root < Type::Map
          register :root

          STAGES = %i(
            before_install
            install
            before_script
            script
            after_script
            after_result
            after_success
            after_failure
            before_deploy
            after_deploy
            before_cache
          )

          def define
            map :language,     required: true
            matrix :os,        required: true, to: :oss
            map :dist,         required: true
            map :group
            map :sudo
            map :osx_image,    to: :scalar, edge: true

            map :addons
            map :branches,     to: :branch_conditions
            map :cache
            map :deploy,       to: :deploys
            map :git
            map :matrix
            map :notifications
            map :services
            map :source_key,   to: :scalar, cast: :secure

            matrix :env

            maps *STAGES, to: :seq

            define_languages
          end

          def define_languages
            Type::Lang.registry.each do |_, const|
              const.new(mappings[:language].types.first)
            end
          end
        end
      end
    end
  end
end
