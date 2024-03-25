# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          def self.provider_names
            consts = Deploy.registry.values
            consts = consts.select { |const| const < Deploy }
            consts.map(&:registry_key).sort.compact
          end

          class Deploys < Type::Seq
            register :deploys

            def define
              title 'Deployments'
              summary 'Deployment target configurations'
              see 'Deployment (v2)': 'https://docs.travis-ci.com/user/deployment-v2'
              normal
              type :providers
              export
            end
          end

          class Providers < Type::Any
            registry :deploy
            register :providers

            def define
              normal
              types *Def::Deploy.provider_names
              detect :provider
              export
            end
          end

          class Deploy < Type::Map
            registry :deploy

            def after_define
              normal

              prefix :provider, only: :str

              map :provider,      to: :str, values: registry_key, required: true, strict: true
              map :on,            to: :conditions, alias: :true
              map :run,           to: :seq
              map :allow_failure, to: :bool
              map :cleanup,       to: :bool
              map :skip_cleanup,  to: :bool, deprecated: 'not supported in dpl v2, use cleanup'
              map :edge,          to: :edge

              # so called option specific branch hashes are valid, but
              # deprecated according to travis-build. e.g.:
              #
              #     provider: lambda
              #     function_name:
              #       develop: foo
              #       production: bar
              #
              # map :'.*', to: :branches

              export
            end
          end

          class Conditions < Type::Map
            registry :deploy
            register :conditions

            def define
              normal
              prefix :branch, only: :str

              map :os
              map :branch,       to: :branches
              map :repo,         to: :str
              map :condition,    to: :seq, type: :str
              map :all_branches, to: :bool
              map :tags,         to: :bool

              includes :support

              export
            end
          end

          class Branches < Type::Any
            registry :deploy
            register :branches

            def define
              type :seq, normal: true
              type :branch
              export
            end
          end

          class Branch < Type::Map
            registry :deploy
            register :branch

            def define
              normal
              strict false
              # branch specific option hashes to be removed in v1.1.0
              deprecated :branch_specific_option_hash
            end
          end

          class Edge < Type::Any
            registry :deploy
            register :edge

            def define
              types :bool, Class.new(Type::Map) {
                def define
                  map :enabled, to: :bool
                  map :source, to: :str
                  map :branch, to: :str
                end
              }
              export
            end
          end
        end
      end
    end
  end
end

require 'travis/yml/schema/def/deploy'
require 'travis/yml/schema/def/deploy/anynines'
require 'travis/yml/schema/def/deploy/azure_web_apps'
require 'travis/yml/schema/def/deploy/bintray'
require 'travis/yml/schema/def/deploy/bluemix_cloudfoundry'
require 'travis/yml/schema/def/deploy/boxfuse'
require 'travis/yml/schema/def/deploy/cargo'
require 'travis/yml/schema/def/deploy/catalyze'
require 'travis/yml/schema/def/deploy/chef_supermarket'
require 'travis/yml/schema/def/deploy/cloud66'
require 'travis/yml/schema/def/deploy/cloudfiles'
require 'travis/yml/schema/def/deploy/cloudfoundry'
require 'travis/yml/schema/def/deploy/cloudformation'
require 'travis/yml/schema/def/deploy/codedeploy'
require 'travis/yml/schema/def/deploy/convox'
require 'travis/yml/schema/def/deploy/ecr'
require 'travis/yml/schema/def/deploy/elasticbeanstalk'
require 'travis/yml/schema/def/deploy/engineyard'
require 'travis/yml/schema/def/deploy/firebase'
require 'travis/yml/schema/def/deploy/flynn'
require 'travis/yml/schema/def/deploy/gleis'
require 'travis/yml/schema/def/deploy/gae'
require 'travis/yml/schema/def/deploy/gcs'
require 'travis/yml/schema/def/deploy/git_push'
require 'travis/yml/schema/def/deploy/hackage'
require 'travis/yml/schema/def/deploy/hephy'
require 'travis/yml/schema/def/deploy/heroku'
require 'travis/yml/schema/def/deploy/lambda'
require 'travis/yml/schema/def/deploy/launchpad'
require 'travis/yml/schema/def/deploy/netlify'
require 'travis/yml/schema/def/deploy/npm'
require 'travis/yml/schema/def/deploy/nuget'
require 'travis/yml/schema/def/deploy/openshift'
require 'travis/yml/schema/def/deploy/opsworks'
require 'travis/yml/schema/def/deploy/packagecloud'
require 'travis/yml/schema/def/deploy/pages'
require 'travis/yml/schema/def/deploy/puppetforge'
require 'travis/yml/schema/def/deploy/pypi'
require 'travis/yml/schema/def/deploy/releases'
require 'travis/yml/schema/def/deploy/rubygems'
require 'travis/yml/schema/def/deploy/s3'
require 'travis/yml/schema/def/deploy/scalingo'
require 'travis/yml/schema/def/deploy/script'
require 'travis/yml/schema/def/deploy/snap'
require 'travis/yml/schema/def/deploy/surge'
require 'travis/yml/schema/def/deploy/testfairy'
require 'travis/yml/schema/def/deploy/transifex'
