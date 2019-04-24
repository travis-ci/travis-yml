# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention elasticbeanstalk
          class Elasticbeanstalk < Deploy
            register :elasticbeanstalk

            def define
              map :access_key_id,           to: :secure
              map :securet_access_key,      to: :secure
              map :region,                  to: :str
              map :app,                     to: :str
              map :env,                     to: :str
              map :zip_file,                to: :str
              map :bucket_name,             to: :str
              map :bucket_path,             to: :str
              map :only_create_app_version, to: :bool
            end
          end
        end
      end
    end
  end
end
