# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Artifacts < Addon
            register :artifacts

            # validate these
            ALIASES = {
              key: %i(
                aws_access_key_id
                aws_access_key
                access_key_id
                access_key
              ),
              secret: %i(
                aws_secret_access_key
                aws_secret_key
                secret_access_key
                secret_key
              )
            }

            def define
              summary 'Build artifacts to upload at the end of the build'
              see 'Uploading Artifacts on Travis CI': 'https://docs.travis-ci.com/user/uploading-artifacts/'

              description <<~str
                Automatically upload your build artifacts to Amazon S3 at the end of a build, after the `after_script` phase.

                Please see [our documentation](https://docs.travis-ci.com/user/uploading-artifacts/) for details.
              str

              map :enabled,       to: :bool, summary: 'Enable or disable uploading artifacts'
              map :bucket,        to: :str, summary: 'The S3 bucket to upload to'
              map :endpoint,      to: :str, summary: 'The S3 compatible endpoint to upload to'
              map :key,           to: :secure, summary: 'The S3 access key id', alias: ALIASES[:key], strict: false
              map :secret,        to: :secure, summary: 'The S3 secret access key', alias: ALIASES[:secret]
              map :region,        to: :str, alias: :s3_region, summary: 'The S3 region'
              map :paths,         to: :seq, summary: 'Paths to the files to upload'

              # can branch be a seq? branch not mentioned in the docs
              map :branch,        to: :str
              map :log_format,    to: :str
              map :target_paths,  to: :seq

              map :debug,         to: :bool
              map :concurrency,   to: :num
              map :max_size,      to: :num

              # TODO how about these keys, can be found in actual configs, but not in the docs
              map :permissions,   to: :str
              map :working_dir,   to: :str
              map :cache_control, to: :str
            end
          end
        end
      end
    end
  end
end
