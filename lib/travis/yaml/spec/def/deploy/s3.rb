module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # dpl says it's access-key-id, docs say it's access-key-id
          # dpl says it's secret-access-key, docs say it's secret-access-key
          class S3 < Deploy
            register :s3

            def define
              super
              map :access_key_id,         to: :scalar, cast: :secure, alias: :'access-key-id'
              map :secret_access_key,     to: :scalar, cast: :secure, alias: :'secret-access-key'
              map :bucket,                to: :scalar
              map :region,                to: :scalar
              map :upload_dir,            to: :scalar, alias: :'upload-dir'
              map :storage_class,         to: :scalar, alias: :'storage-class'
              map :local_dir,             to: :scalar
              map :detect_encoding,       to: :scalar, cast: :bool
              map :cache_control,         to: :scalar
              map :expires,               to: :scalar
              map :acl,                   to: :scalar
              map :dot_match,             to: :scalar, cast: :bool
              map :index_document_suffix, to: :scalar
              map :default_text_charset,  to: :scalar
            end
          end
        end
      end
    end
  end
end
