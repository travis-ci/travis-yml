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

            map :before_install, to: :seq
            map :install,        to: :seq
            map :after_install,  to: :seq
            map :before_script,  to: :seq
            map :script,         to: :seq
            map :after_script,   to: :seq
            map :after_result,   to: :seq
            map :after_success,  to: :seq #, alias: :on_success
            map :after_failure,  to: :seq #, alias: :on_failure ?
            map :before_deploy,  to: :seq
            map :after_deploy,   to: :seq
            map :before_cache,   to: :seq

            export
          end
        end
      end
    end
  end
end
