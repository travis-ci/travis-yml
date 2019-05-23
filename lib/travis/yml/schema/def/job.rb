# frozen_string_literal: true
require 'travis/yml/schema/def/addons'
require 'travis/yml/schema/def/branches'
require 'travis/yml/schema/def/cache'
require 'travis/yml/schema/def/deploy'
require 'travis/yml/schema/def/git'
require 'travis/yml/schema/def/group'
require 'travis/yml/schema/def/services'
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        class Job < Dsl::Map
          register :job

          URLS = {
            lifecycle: 'https://docs.travis-ci.com/user/job-lifecycle'
          }

          def define
            strict false

            map :group
            map :osx_image, to: :str, edge: true, only: { os: :osx } # TODO move the opts to the definition

            map :services
            map :addons
            map :branches, alias: :branch # TODO move the alias to the definition
            map :cache
            map :deploy,     to: :deploys
            map :git
            map :source_key, to: :secure
            map :if,         to: :str

            map :before_install, to: :seq, summary: 'Scripts to run before the install stage'
            map :install,        to: :seq, summary: 'Scripts to run at the install stage'
            map :after_install,  to: :seq, summary: 'Scripts to run after the install stage'
            map :before_script,  to: :seq, summary: 'Scripts to run before the script stage'
            map :script,         to: :seq, summary: 'Scripts to run at the script stage'
            map :after_script,   to: :seq, summary: 'Scripts to run after the script stage'
            map :after_result,   to: :seq, summary: 'Scripts to run after [umm, wat? i do not think this exists]'
            map :after_success,  to: :seq, summary: 'Scripts to run after a successful script stage'
            map :after_failure,  to: :seq, summary: 'Scripts to run after a failing script stage'
            map :before_deploy,  to: :seq, summary: 'Scripts to run before the deploy stage'
            map :after_deploy,   to: :seq, summary: 'Scripts to run after the deploy stage'
            map :before_cache,   to: :seq, summary: 'Scripts to run after before storing a build cache'

            export
          end
        end
      end
    end
  end
end
