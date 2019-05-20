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
              map :username,           to: :secure, strict: false, alias: :user
              map :password,           to: :secure
              map :api_key,            to: :secure
              map :server,             to: :str
              map :distributions,      to: :str
              map :docs_dir,           to: :str
              map :skip_existing,      to: :bool
              map :skip_upload_docs,   to: :bool
              map :setuptools_version, to: :str
              map :twine_version,      to: :str
              map :wheel_version,      to: :str
            end
          end
        end
      end
    end
  end
end
