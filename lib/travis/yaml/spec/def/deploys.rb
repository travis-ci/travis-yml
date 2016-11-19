require 'travis/yaml/spec/def/deploy'
require 'travis/yaml/spec/def/deploy/anynines'
require 'travis/yaml/spec/def/deploy/appfog'
require 'travis/yaml/spec/def/deploy/atlas'
require 'travis/yaml/spec/def/deploy/azure_web_apps'
require 'travis/yaml/spec/def/deploy/bintray'
require 'travis/yaml/spec/def/deploy/bitballoon'
require 'travis/yaml/spec/def/deploy/boxfuse'
require 'travis/yaml/spec/def/deploy/catalyze'
require 'travis/yaml/spec/def/deploy/chef_supermarket'
require 'travis/yaml/spec/def/deploy/cloud66'
require 'travis/yaml/spec/def/deploy/cloudcontrol'
require 'travis/yaml/spec/def/deploy/cloudfiles'
require 'travis/yaml/spec/def/deploy/cloudfoundry'
require 'travis/yaml/spec/def/deploy/codedeploy'
require 'travis/yaml/spec/def/deploy/deis'
require 'travis/yaml/spec/def/deploy/divshot'
require 'travis/yaml/spec/def/deploy/elasticbeanstalk'
require 'travis/yaml/spec/def/deploy/engineyard'
require 'travis/yaml/spec/def/deploy/exoscale'
require 'travis/yaml/spec/def/deploy/gae'
require 'travis/yaml/spec/def/deploy/gcs'
require 'travis/yaml/spec/def/deploy/hackage'
require 'travis/yaml/spec/def/deploy/heroku'
require 'travis/yaml/spec/def/deploy/lambda'
require 'travis/yaml/spec/def/deploy/launchpad'
require 'travis/yaml/spec/def/deploy/modulus'
require 'travis/yaml/spec/def/deploy/nodejitsu'
require 'travis/yaml/spec/def/deploy/npm'
require 'travis/yaml/spec/def/deploy/openshift'
require 'travis/yaml/spec/def/deploy/opsworks'
require 'travis/yaml/spec/def/deploy/packagecloud'
require 'travis/yaml/spec/def/deploy/pages'
require 'travis/yaml/spec/def/deploy/puppetforge'
require 'travis/yaml/spec/def/deploy/pypi'
require 'travis/yaml/spec/def/deploy/releases'
require 'travis/yaml/spec/def/deploy/rubygems'
require 'travis/yaml/spec/def/deploy/s3'
require 'travis/yaml/spec/def/deploy/scalingo'
require 'travis/yaml/spec/def/deploy/script'
require 'travis/yaml/spec/def/deploy/surge'
require 'travis/yaml/spec/def/deploy/testfairy'
require 'travis/yaml/spec/type/lookup'

module Travis
  module Yaml
    module Spec
      module Def
        class Deploys < Type::Seq
          register :deploys

          def define
            type Type::Lookup[:provider], *%i(
              anynines appfog atlas azure_web_apps bintray bitballoon boxfuse
              catalyze chef_supermarket cloud66 cloudcontrol cloudfiles
              cloudfoundry codedeploy deis divshot elasticbeanstalk engineyard
              exoscale gae gcs hackage heroku lambda launchpad modulus
              nodejitsu npm openshift opsworks packagecloud pages puppetforge
              pypi releases rubygems s3 scalingo script surge testfairy
            )
            prefix :provider, type: :scalar
          end
        end
      end
    end
  end
end
