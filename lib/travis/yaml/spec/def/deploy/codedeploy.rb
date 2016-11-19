module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # dpl readme says it's access-key-id, docs say it's access_key_id
          # dpl readme says it's secret-access-key, docs say it's secret_access_key
          # dpl readme does not mention bucket
          # dpl readme does not mention key
          # docs do not mention commit_id
          class Codedeploy < Deploy
            register :codedeploy

            def define
              super
              map :access_key_id,       to: :scalar, cast: :secure, alias: :'access-key-id'
              map :secret_access_key,   to: :scalar, cast: :secure, alias: :'secret-access-key'
              map :application,         to: :scalar
              map :deployment_group,    to: :scalar
              map :revision_type,       to: :fixed, values: %i(s3 github), ignore_case: true # TODO test this
              map :commit_id,           to: :scalar
              map :repository,          to: :scalar
              map :region,              to: :scalar
              map :wait_until_deployed, to: :scalar, cast: :bool, alias: :'wait-until-deployed'
              map :bucket,              to: :scalar
              map :key,                 to: :scalar
            end
          end
        end
      end
    end
  end
end
