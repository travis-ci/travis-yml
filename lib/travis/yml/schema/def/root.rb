# frozen_string_literal: true
require 'travis/yml/schema/def/arch'
require 'travis/yml/schema/def/compilers'
require 'travis/yml/schema/def/conditions'
require 'travis/yml/schema/def/dist'
require 'travis/yml/schema/def/env'
require 'travis/yml/schema/def/imports'
require 'travis/yml/schema/def/job'
require 'travis/yml/schema/def/jobs'
require 'travis/yml/schema/def/language'
require 'travis/yml/schema/def/notification'
require 'travis/yml/schema/def/os'
require 'travis/yml/schema/def/stack'
require 'travis/yml/schema/def/stages'
require 'travis/yml/schema/def/sudo'
require 'travis/yml/schema/def/version'
require 'travis/yml/schema/def/virt'
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Root < Type::Schema
          register :root

          DEFAULT = {
            language: [
              { value: :ruby, except: { os: [:osx] } },
              { value: :'objective-c', only: { os: :osx } }
            ],
            dist: [
              { value: :xenial, only: { os: [:linux, :'linux-ppc64le'] } }
            ],
            os: [
              { value: :linux, except: { language: 'objective-c' } },
              { value: :osx, only: { language: 'objective-c' } }
            ]
          }

          def define
            title 'JSON schema for Travis CI configuration files'

            description <<~str
              The root node of your build config.
            str

            see 'Job lifecycle': 'https://docs.travis-ci.com/user/job-lifecycle/'

            map    :language,       default: DEFAULT[:language]
            matrix :os,             default: DEFAULT[:os], to: :oss
            map    :dist,           default: DEFAULT[:dist]
            matrix :arch,           to: :archs
            map    :virt
            map    :stack
            map    :sudo
            map    :import,         to: :imports
            map    :env
            matrix :compiler,       to: :compilers
            matrix :osx_image,      to: :osx_images
            map    :stages
            map    :jobs,           alias: :matrix
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
