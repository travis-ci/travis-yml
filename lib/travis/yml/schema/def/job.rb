# frozen_string_literal: true
require 'travis/yml/schema/def/addons'
require 'travis/yml/schema/def/branches'
require 'travis/yml/schema/def/cache'
require 'travis/yml/schema/def/deploy'
require 'travis/yml/schema/def/git'
require 'travis/yml/schema/def/group'
require 'travis/yml/schema/def/osx_image'
require 'travis/yml/schema/def/services'
require 'travis/yml/schema/def/workspaces'
require 'travis/yml/schema/def/keys'
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Job < Type::Map
          register :job

          # URLS = {
          #   lifecycle: 'https://docs.travis-ci.com/user/job-lifecycle'
          # }

          def define
            strict false

            map :virt
            map :addons
            map :branches
            map :cache
            map :deploy,     to: :deploys
            map :git
            map :if,         to: :condition
            map :services
            map :group
            map :workspaces
            map :keys

            map :before_install, to: :seq, summary: 'Scripts to run before the install stage'
            map :install,        to: :seq, summary: 'Scripts to run at the install stage'
            map :before_script,  to: :seq, summary: 'Scripts to run before the script stage'
            map :script,         to: :seq, summary: 'Scripts to run at the script stage'
            map :before_cache,   to: :seq, summary: 'Scripts to run before storing a build cache'
            map :after_success,  to: :seq, summary: 'Scripts to run after a successful script stage'
            map :after_failure,  to: :seq, summary: 'Scripts to run after a failing script stage'
            map :before_deploy,  to: :seq, summary: 'Scripts to run before the deploy stage'
            map :after_deploy,   to: :seq, summary: 'Scripts to run after the deploy stage'
            map :after_script,   to: :seq, summary: 'Scripts to run as the last stage'

            export
          end
        end
      end
    end
  end
end
