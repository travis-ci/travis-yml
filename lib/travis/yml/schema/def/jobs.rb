# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Jobs < Type::Map
          register :jobs

          def define
            title 'Job Matrix'
            summary 'Build matrix definitions'
            see 'Build Matrix': 'https://docs.travis-ci.com/user/build-matrix/'

            normal
            aliases :matrix
            prefix :include

            map :include,        to: :jobs_entries, summary: 'Jobs to include to the build matrix'
            map :exclude,        to: :jobs_entries, summary: 'Attributes of jobs to exclude from the build matrix'
            map :allow_failures, to: :jobs_entries, alias: :allowed_failures, summary: 'Attributes of jobs that are allowed to fail'
            map :fast_finish,    to: :bool, alias: :fast_failure, summary: 'Allow the build to fail fast'

            export
          end
        end

        class JobsEntries < Type::Seq
          register :jobs_entries

          def define
            title 'Job Matrix Entries'
            type :jobs_entry
            export
          end
        end

        class JobsEntry < Type::Map
          register :jobs_entry

          def define
            title 'Job Matrix Entry'
            strict false
            aliases :jobs

            map :language
            map :os
            map :dist
            map :arch
            map :sudo
            map :env,      to: :env_vars
            map :compiler
            map :name,     to: :str, unique: true
            map :stage,    to: :str

            includes :support, :job

            export
          end
        end
      end
    end
  end
end
