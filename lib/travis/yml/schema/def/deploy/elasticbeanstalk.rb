# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Elasticbeanstalk < Deploy
            register :elasticbeanstalk

            def define
              map :access_key_id,           to: :secure, strict: false
              map :secret_access_key,       to: :secure
              map :region,                  to: :str
              map :app,                     to: :map, type: :str
              map :env,                     to: :map, type: :str # docs are unclear on this, but users seem to expect this?
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
