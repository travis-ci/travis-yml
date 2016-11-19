module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention custom_json
          # docs do not mention instance_ids
          # docs do not mention layer_ids
          class Opsworks < Deploy
            register :opsworks

            def define
              super
              map :access_key_id,       to: :scalar, cast: :secure, alias: :'access-key-id'
              map :secret_access_key,   to: :scalar, cast: :secure, alias: :'secret-access-key'
              map :app_id,              to: :scalar, alias: :'app-id'
              map :instance_ids,        to: :scalar, alias: :'instance-ids'
              map :layer_ids,           to: :scalar, alias: :'layer-ids'
              map :migrate,             to: :scalar, cast: :bool
              map :wait_until_deployed, to: :scalar, alias: :'wait-until-deployed'
              map :custom_json,         to: :scalar
            end
          end
        end
      end
    end
  end
end
