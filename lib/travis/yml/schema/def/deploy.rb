# frozen_string_literal: true
require 'travis/yml/schema/dsl/enum'
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          def self.providers
            @providers ||= begin
              consts = ObjectSpace.each_object(::Class)
              consts = consts.select { |const| const < Deploy }
              consts.map(&:registry_key).sort
            end
          end

          class Deploys < Dsl::Any
            register :deploys

            def define
              normal

              add :seq, type: Class.new(Dsl::Any) {
                def define
                  normal
                  add *Def::Deploy.providers
                  detect :provider
                end
              }

              export
            end
          end

          class Deploy < Dsl::Map
            register :deploy

            def define
              namespace :deploy
              normal

              strict false
              prefix :provider

              map :provider,      to: :enum, values: registry_key, required: true, strict: true
              map :on,            to: :deploy_conditions
              map :allow_failure, to: :bool
              map :skip_cleanup,  to: :bool
              map :edge,          to: :deploy_edge

              change :enable

              # so called option specific branch hashes are valid, but
              # deprecated according to travis-build. e.g.:
              #
              #     provider: lambda
              #     function_name:
              #       develop: foo
              #       production: bar

              # map :'.*', to: :deploy_branches

              # export
            end
          end

          class App < Dsl::Any
            register :app

            def define
              add Class.new(Dsl::Map) {
                def define
                  strict false
                  map '.*', to: :str
                end
              }
              add :str

              export
            end
          end

          class Conditions < Dsl::Map
            register :deploy_conditions

            def define
              include :languages

              normal
              prefix :branch

              map :branch,       to: :deploy_branches, alias: :branches
              map :repo,         to: :str
              map :condition,    to: :str
              map :all_branches, to: :bool
              map :tags,         to: :bool

              export
            end
          end

          class Branches < Dsl::Any
            register :deploy_branches

            def define
              add :seq, normal: true #, prefix: :branch
              # add Branch
              export
            end
          end

          class Branch < Dsl::Map
            register :deploy_branch

            def define
              normal
              strict false
              # branch specific option hashes to be removed in v1.1.0
              deprecated :branch_specific_option_hash
            end
          end

          class Edge < Dsl::Map
            register :deploy_edge

            def define
              edge
              map :enabled, to: :bool
              map :source, to: :str
              map :branch, to: :str
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
require 'travis/yml/schema/def/deploy/appfog'
require 'travis/yml/schema/def/deploy/atlas'
require 'travis/yml/schema/def/deploy/azure_web_apps'
require 'travis/yml/schema/def/deploy/bintray'
require 'travis/yml/schema/def/deploy/bitballoon'
require 'travis/yml/schema/def/deploy/bluemix_cloudfoundry'
require 'travis/yml/schema/def/deploy/boxfuse'
require 'travis/yml/schema/def/deploy/catalyze'
require 'travis/yml/schema/def/deploy/chef_supermarket'
require 'travis/yml/schema/def/deploy/cloud66'
require 'travis/yml/schema/def/deploy/cloudcontrol'
require 'travis/yml/schema/def/deploy/cloudfiles'
require 'travis/yml/schema/def/deploy/cloudfoundry'
require 'travis/yml/schema/def/deploy/codedeploy'
require 'travis/yml/schema/def/deploy/deis'
require 'travis/yml/schema/def/deploy/divshot'
require 'travis/yml/schema/def/deploy/elasticbeanstalk'
require 'travis/yml/schema/def/deploy/engineyard'
require 'travis/yml/schema/def/deploy/firebase'
require 'travis/yml/schema/def/deploy/gae'
require 'travis/yml/schema/def/deploy/gcs'
require 'travis/yml/schema/def/deploy/hackage'
require 'travis/yml/schema/def/deploy/heroku'
require 'travis/yml/schema/def/deploy/lambda'
require 'travis/yml/schema/def/deploy/launchpad'
require 'travis/yml/schema/def/deploy/modulus'
require 'travis/yml/schema/def/deploy/npm'
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
require 'travis/yml/schema/def/deploy/surge'
require 'travis/yml/schema/def/deploy/testfairy'
