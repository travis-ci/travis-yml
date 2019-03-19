# frozen_string_literal: true
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
              map :access_key_id,          to: :str, secure: true
              map :secret_access_key,      to: :str, secure: true
              map :bucket,                 to: :str
              map :region,                 to: :str
              map :upload_dir,             to: :str
              map :storage_class,          to: :str
              map :local_dir,              to: :str
              map :detect_encoding,        to: :bool
              map :cache_control,          to: :str
              map :expires,                to: :str
              map :acl,                    to: :str
              map :dot_match,              to: :bool
              map :index_document_suffix,  to: :str
              map :default_text_charset,   to: :str
              map :server_side_encryption, to: :bool
            end
          end
        end
      end
    end
  end
end
