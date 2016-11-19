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
              map :access_key_id,     to: :scalar, cast: :secure, required: true
              map :secret_access_key, to: :scalar, cast: :secure, required: true
              map :region,            to: :scalar
              map :function_name,     to: :scalar, required: true
              map :role,              to: :scalar, required: true
              map :handler_name,      to: :scalar, required: true
              map :module_name,       to: :scalar
              map :zip,               to: :scalar
              map :description,       to: :scalar
              map :timeout,           to: :scalar
              map :memory_size,       to: :scalar
              map :runtime,           to: :scalar
            end
          end
        end
      end
    end
  end
end
