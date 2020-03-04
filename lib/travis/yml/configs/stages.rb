require 'travis/yml/configs/model/job'
require 'travis/yml/configs/model/stage'
require 'travis/yml/helper/condition'

module Travis
  module Yml
    module Configs
      class Stages < Struct.new(:config, :jobs, :data)
        # This will use the stage order defined in the :stages section, or an
        # empty array if none. Any stage names that not present in the stages
        # section, but are present in the jobs list, will be appended to the
        # stages section, i.e. sorted to the end of the list.

        include Model, Memoize

        DEFAULT_NAME = 'test'

        def apply
          return result unless stages?
          assign_names
          filter_stages
          filter_jobs
          result
        end

        private

          def stages?
            configs.any? || jobs.map(&:stage).any?
          end

          def result
            [stages.map(&:attrs), jobs.map(&:attrs)]
          end

          def assign_names
            jobs.inject(default_name) do |name, job|
              job.stage ||= name
            end
          end

          def filter_stages
            @stages = stages.select { |stage| accept?(stage) }.reject { |stage| empty?(stage) }
          end

          def filter_jobs
            @jobs = jobs.select { |job| stages.any? { |stage| stage.name.casecmp(job.stage) == 0 } }
          end

          def stages
            @stages ||= configs.dup.concat(job_stages).map { |attrs| Stage.new(attrs) }.uniq
          end

          def job_stages
            jobs.map(&:stage).compact.map { |name| { name: name } }
          end

          def jobs_on(stage)
            jobs.select { |job| job.stage.casecmp(stage.name) == 0 }
          end

          def jobs
            @jobs ||= super.map { |attrs| Job.new(attrs) }
          end

          def accept?(stage)
            jobs_on(stage).any? { |job| Condition.new(stage.cond, job.attrs, data).accept? }
          end

          def empty?(stage)
            jobs.none? { |job| stage.includes?(job) }
          end

          def configs
            Array(config[:stages])
          end

          def default_name
            @default_name ||= names.detect { |name| name.downcase == DEFAULT_NAME } || DEFAULT_NAME
          end

          def names
            names = configs.map { |stage| stage[:name] } + jobs.map(&:stage)
            names.compact.uniq
          end
      end
    end
  end
end
