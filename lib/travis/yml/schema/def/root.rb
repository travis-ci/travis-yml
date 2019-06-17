# frozen_string_literal: true
require 'travis/yml/schema/def/arch'
require 'travis/yml/schema/def/compilers'
require 'travis/yml/schema/def/conditions'
require 'travis/yml/schema/def/dist'
require 'travis/yml/schema/def/env'
require 'travis/yml/schema/def/imports'
require 'travis/yml/schema/def/job'
require 'travis/yml/schema/def/language'
require 'travis/yml/schema/def/matrix'
require 'travis/yml/schema/def/notification'
require 'travis/yml/schema/def/os'
require 'travis/yml/schema/def/stack'
require 'travis/yml/schema/def/stages'
require 'travis/yml/schema/def/sudo'
require 'travis/yml/schema/def/version'
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Root < Type::Schema
          register :root

          def define
            title 'JSON schema for Travis CI configuration files'

            description <<~str
              The root node of your build config.
            str

            see 'Job lifecycle': 'https://docs.travis-ci.com/user/job-lifecycle/'

            map    :language,       required: true
            matrix :os,             required: true, to: :oss
            map    :dist
            matrix :arch,           to: :archs
            map    :stack
            map    :sudo
            map    :import,         to: :imports
            matrix :env
            matrix :compiler,       to: :compilers
            map    :stages
            map    :matrix,         alias: :jobs
            map    :notifications

            map    :version
            map    :conditions,     to: :conditions
            map    :filter_secrets, to: :bool, internal: true, summary: 'Whether to filter secrets from the log output'
            map    :trace,          to: :bool, internal: true, summary: 'Whether to trace the build script'

            includes :languages, :job

            strict false
          end
        end
      end
    end
  end
end
