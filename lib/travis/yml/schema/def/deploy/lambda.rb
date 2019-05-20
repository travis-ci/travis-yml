# frozen_string_literal: true
module Travis
  module Yml
    module Schema
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
              map :access_key_id,         to: :secure, strict: false #, required: true
              map :secret_access_key,     to: :secure #, required: true
              map :region,                to: :str
              map :function_name,         to: :str #, required: true
              map :role,                  to: :str #, required: true
              map :handler_name,          to: :str #, required: true
              map :module_name,           to: :str
              map :zip,                   to: :str
              map :description,           to: :str
              map :timeout,               to: :str
              map :memory_size,           to: :str
              map :runtime,               to: :str
              map :environment_variables, to: :secure # TODO ?
              map :security_group_ids,    to: :seq
              map :subnet_ids,            to: :seq
              map :dead_letter_config,    to: :str
              map :kms_key_arn,           to: :str
              map :tracing_mode,          to: :str, values: %i(Active PassThrough) #, default: :PassThrough
              map :publish,               to: :bool
              map :function_tags,         to: :secure # TODO ?
              map :dot_match,             to: :bool
              map :dead_letter_arn,       to: :str
            end
          end
        end
      end
    end
  end
end
