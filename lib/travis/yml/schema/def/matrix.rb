# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Matrix < Type::Map
          register :matrix

          def define
            summary 'Build matrix definitions'
            see 'Build Matrix': 'https://docs.travis-ci.com/user/build-matrix/'

            normal
            aliases :jobs
            prefix :include

            map :include,        to: :matrix_entries, summary: 'Jobs to include to the build matrix'
            map :exclude,        to: :matrix_entries, summary: 'Attributes of jobs to exclude from the build matrix'
            map :allow_failures, to: :matrix_entries, alias: :allowed_failures, summary: 'Attributes of jobs that are allowed to fail'
            map :fast_finish,    to: :bool, alias: :fast_failure, summary: 'Allow the build to fail fast'

            export
          end
        end

        class MatrixEntries < Type::Seq
          register :matrix_entries

          def define
            type :matrix_entry
            export
          end
        end

        class Entry < Type::Map
          register :matrix_entry

          def define
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
