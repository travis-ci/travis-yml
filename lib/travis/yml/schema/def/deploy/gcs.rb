# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention upload-dir
          # docs do not mention local-dir
          # docs do not mention dot_match
          class Gcs < Deploy
            register :gcs

            def define
              map :access_key_id,     to: :secure
              map :secret_access_key, to: :secure
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
