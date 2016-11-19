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
              map :access_key_id,     to: :str, secure: true
              map :secret_access_key, to: :str, secure: true
              map :bucket,            to: :str
              map :upload_dir,        to: :str
              map :local_dir,         to: :str
              map :dot_match,         to: :bool
              map :acl,               to: :str
              map :cache_control,     to: :str
              map :detect_encoding,   to: :bool
            end
          end
        end
      end
    end
  end
end
