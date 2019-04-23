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

            strict false

            map    :version
            map    :import,         to: :imports
            map    :language,       required: true
            matrix :os,             required: true, to: :oss
            matrix :arch,           to: :archs
            map    :dist
            map    :sudo
            matrix :env
            matrix :compiler,       to: :compilers
            map    :matrix,         alias: :jobs
            map    :stages
            map    :notifications
            map    :stack
            map    :conditions,     to: :conditions #, default: :v1
            map    :filter_secrets, to: :bool
            map    :trace,          to: :bool

            include :job
          end
        end
      end
    end
  end
end
