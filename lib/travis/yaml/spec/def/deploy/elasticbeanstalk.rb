module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention elasticbeanstalk
          class Elasticbeanstalk < Deploy
            register :elasticbeanstalk

            def define
              super
              map :access_key_id,           to: :scalar, cast: :secure, alias: :'access-key-id'
              map :securet_access_key,      to: :scalar, cast: :secure, alias: :'secret-access-key'
              map :region,                  to: :scalar
              map :app,                     to: :scalar
              map :env,                     to: :scalar
              map :zip_file,                to: :scalar
              map :bucket_name,             to: :scalar
              map :bucket_path,             to: :scalar
              map :only_create_app_version, to: :scalar, cast: :bool
            end
          end
        end
      end
    end
  end
end
