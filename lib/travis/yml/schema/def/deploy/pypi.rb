# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Pypi < Deploy
            register :pypi

            def define
              map :username,           to: :secure, strict: false, alias: :user
              map :password,           to: :secure
              map :server,             to: :str
              map :distributions,      to: :str
              map :docs_dir,           to: :str
              map :skip_existing,      to: :bool
              map :upload_docs,        to: :bool
              map :skip_upload_docs,   to: :bool, deprecated: 'use upload_docs: false'
              map :twine_check,        to: :bool
              map :remove_build_dir,   to: :bool
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
