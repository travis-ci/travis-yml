# frozen_string_literal: true
module Travis
  module Yml
    module Schema
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
              map :access_key_id,       to: :secure
              map :secret_access_key,   to: :secure
              map :application,         to: :str
              map :deployment_group,    to: :str
              map :revision_type,       to: :enum, values: %i(s3 github) #, ignore_case: true TODO
              map :commit_id,           to: :str
              map :repository,          to: :str
              map :region,              to: :str
              map :wait_until_deployed, to: :bool
              map :bucket,              to: :str
              map :key,                 to: :str
              map :bundle_type,         to: :str
            end
          end
        end
      end
    end
  end
end
