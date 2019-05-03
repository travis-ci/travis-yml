# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention docs_dir
          class Pypi < Deploy
            register :pypi

            def define
              map :user,             to: :secure, strict: false
              map :password,         to: :secure
              map :api_key,          to: :secure
              map :server,           to: :str
              map :distributions,    to: :str
              map :docs_dir,         to: :str
              map :skip_existing,    to: :bool
              map :skip_upload_docs, to: :bool
            end
          end
        end
      end
    end
  end
end
