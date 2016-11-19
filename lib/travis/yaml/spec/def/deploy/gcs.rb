module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention upload-dir
          # docs do not mention local-dir
          # docs do not mention dot_match
          class Gcs < Deploy
            register :gcs

            def define
              super
              map :access_key_id,     to: :scalar, cast: :secure, alias: :'access-key-id'
              map :secret_access_key, to: :scalar, cast: :secure, alias: :'secret-access-key'
              map :bucket,            to: :scalar
              map :upload_dir,        to: :scalar, alias: :'upload-dir'
              map :local_dir,         to: :scalar, alias: :'local-dir'
              map :dot_match,         to: :scalar, cast: :bool
              map :acl,               to: :scalar
              map :cache_control,     to: :scalar
              map :detect_encoding,   to: :scalar, cast: :bool
            end
          end
        end
      end
    end
  end
end
