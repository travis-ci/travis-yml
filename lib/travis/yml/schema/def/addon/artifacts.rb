# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Artifacts < Addon
            register :artifacts

            def define
              # change :enable

              map :enabled,       to: :bool
              map :bucket,        to: :str
              map :endpoint,      to: :str
              map :key,           to: :secure, alias: %i(aws_access_key access_key) # TODO validate these
              map :secret,        to: :secure, alias: %i(secret_key secret_access_key aws_secret aws_secret_key aws_secret_access_key)
              map :paths,         to: :seq

              map :branch,        to: :str
              map :log_format,    to: :str
              map :target_paths,  to: :seq

              map :debug,         to: :bool
              map :concurrency,   to: :num
              map :max_size,      to: :num

              map :region,        to: :str, alias: :s3_region

              # TODO how about these keys, can be found in actual configs, but not in the docs
              map :permissions,   to: :str
              map :working_dir,   to: :str
              map :cache_control, to: :str

              super
            end
          end
        end
      end
    end
  end
end
