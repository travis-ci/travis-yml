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
            see 'Build Matrix': 'https://docs.travis-ci.com/user/build-matrix/',
                'Customizing the build': 'https://docs.travis-ci.com/user/customizing-the-build#build-matrix'

            normal
            aliases :matrix
            prefix :include

            map :include,        to: :jobs_includes, summary: 'Jobs to include to the build matrix'
            map :exclude,        to: :jobs_excludes, summary: 'Attributes of jobs to exclude from the build matrix'
            map :allow_failures, to: :jobs_allow_failures, alias: :allowed_failures, summary: 'Attributes of jobs that are allowed to fail'
            map :fast_finish,    to: :bool, alias: :fast_failure, summary: 'Allow the build to fail fast'

            export
          end
        end

        class JobsIncludes < Type::Seq
          register :jobs_includes

          def define
            title 'Job Matrix Includes'
            type :jobs_include
            export
          end
        end

        class JobsExcludes < Type::Seq
          register :jobs_excludes

          def define
            title 'Job Matrix Excludes'
            type :jobs_exclude
            export
          end
        end

        class JobsAllowFailures < Type::Seq
          register :jobs_allow_failures

          def define
            title 'Job Matrix Allow Failures'
            type :jobs_allow_failure
            export
          end
        end

        class BaseEntry < Type::Map
          def define
            map :language
            map :os
            map :dist
            map :arch
            map :osx_image
            map :sudo
            map :vm
            map :env,      to: :env_vars
            map :compiler
            map :branches
            map :name,     to: :str, unique: true
            map :stage,    to: :str

            includes :support, :job
          end
        end

        class JobsInclude < BaseEntry
          register :jobs_include

          def define
            title 'Job Matrix Includes'
            strict false
            aliases :jobs

            super
            map :allow_failure, to: :bool
            map :vault, to: :vault

            export
          end
        end

        class JobsExclude < BaseEntry
          register :jobs_exclude

          def define
            title 'Job Matrix Exclude'
            strict false
            super
            export
          end
        end

        class JobsAllowFailure < BaseEntry
          register :jobs_allow_failure

          def define
            title 'Job Matrix Allow Failure'

            see 'Jobs that are allowed to fail': 'https://docs.travis-ci.com/user/customizing-the-build#jobs-that-are-allowed-to-fail',
                'Conditionally allowing jobs to fail': 'https://docs.travis-ci.com/user/conditional-builds-stages-jobs#conditionally-allowing-jobs-to-fail'

            strict false

            super
            map :branch, to: :str, deprecated: 'use conditional allow_failures using :if'

            export
          end
        end
      end
    end
  end
end
