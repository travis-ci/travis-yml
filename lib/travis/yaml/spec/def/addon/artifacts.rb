require 'travis/yaml/spec/type/map'

module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Artifacts < Type::Map
            register :artifacts

            def define
              change :enable

              map :enabled,       to: :bool
              map :bucket,        to: :str
              map :endpoint,      to: :str
              map :key,           to: :str, secure: true, alias: %i(aws_access_key access_key) # TODO validate these
              map :secret,        to: :str, secure: true, alias: %i(secret_key secret_access_key aws_secret aws_secret_key aws_secret_access_key)
              map :paths,         to: :seq

              map :branch,        to: :str
              map :log_format,    to: :str
              map :target_paths,  to: :str

              map :debug,         to: :bool
              map :concurrency,   to: :str
              map :max_size,      to: :str

              map :region,        to: :str, alias: :s3_region

              # TODO how about these keys, can be found in actual configs, but not in the docs
              map :permissions,   to: :str
              map :working_dir,   to: :str
              map :cache_control, to: :str
              map :target_paths,  to: :str
            end
          end
        end
      end
    end
  end
end
