require 'travis/yaml/spec/type/map'

module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Artifacts < Type::Map
            register :artifacts

            def define
              normalize :enabled

              map :enabled,      to: :scalar, cast: :bool
              map :bucket,       to: :scalar, cast: :secure
              map :endpoint,     to: :scalar, cast: :secure
              map :key,          to: :scalar, cast: :secure
              map :secret,       to: :scalar, cast: :secure
              map :paths,        to: :seq

              map :branch,       to: :scalar
              map :log_format,   to: :scalar
              map :target_paths, to: :scalar

              map :debug,        to: :scalar, cast: :bool
              map :concurrency,  to: :scalar
              map :max_size,     to: :scalar

              map :s3_region,    to: :scalar

              # TODO how about these keys, can be found in actual configs
              #
              # map :aws_access_key, to: :scalar
              # map :aws_secret_key, to: :scalar
              # map :s3_bucket ,     to: :scalar
              # map :working_dir,    to: :scalar
            end
          end
        end
      end
    end
  end
end
