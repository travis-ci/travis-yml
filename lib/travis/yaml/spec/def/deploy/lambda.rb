module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention region
          # docs do not mention module_name
          # docs do not mention zip
          # docs do not mention description
          # docs do not mention timeout
          # docs do not mention memory_size
          # docs do not mention runtime
          class Lambda < Deploy
            register :lambda

            def define
              super
              map :access_key_id,         to: :str, secure: true, required: true
              map :secret_access_key,     to: :str, secure: true, required: true
              map :region,                to: :str
              map :function_name,         to: :str, required: true
              map :role,                  to: :str, required: true
              map :handler_name,          to: :str, required: true
              map :module_name,           to: :str
              map :zip,                   to: :str
              map :description,           to: :str
              map :timeout,               to: :str
              map :memory_size,           to: :str
              map :runtime,               to: :str
              map :environment_variables, to: [:scalar, :map], secure: true
              map :security_group_ids,    to: :seq
              map :subnet_ids,            to: :seq
              map :dead_letter_config,    to: :str
              map :kms_key_arn,           to: :str
              map :tracing_mode,          to: :str
            end
          end
        end
      end
    end
  end
end
