# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention custom_json
          # docs do not mention instance_ids
          # docs do not mention layer_ids
          class Opsworks < Deploy
            register :opsworks

            def define
              map :access_key_id,         to: :secure, strict: false
              map :secret_access_key,     to: :secure
              map :region,                to: :str
              map :app_id,                to: :str
              map :instance_ids,          to: :strs
              map :layer_ids,             to: :strs
              map :migrate,               to: :bool
              map :wait_until_deployed,   to: :str
              map :custom_json,           to: :str
              map :update_on_success,     to: :bool, alias: :update_app_on_success
              map :wait_until_deployed,   to: :bool
            end
          end
        end
      end
    end
  end
end
