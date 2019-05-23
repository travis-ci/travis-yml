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
require 'travis/yml/schema/dsl/schema'

module Travis
  module Yml
    module Schema
      module Def
        class Root < Dsl::Schema
          register :root

          def define
            title 'JSON schema for Travis CI configuration files'

            description <<~str
              The root node of your build config.

              For details on the build lifecycle see [docs](...).
            str

            map    :version
            map    :import,         to: :imports
            map    :language,       required: true
            matrix :os,             required: true, to: :oss
            matrix :arch,           to: :archs
            map    :dist
            map    :stack
            map    :sudo
            matrix :env
            matrix :compiler,       to: :compilers
            map    :stages
            map    :matrix,         alias: :jobs
            map    :notifications
            map    :conditions,     to: :conditions, internal: true
            map    :filter_secrets, to: :bool, internal: true, summary: 'Whether to filter secrets from the log output'
            map    :trace,          to: :bool, internal: true, summary: 'Whether to trace the build script'

            include :languages, :job

            strict false
          end
        end
      end
    end
  end
end
