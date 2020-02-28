require 'travis/yml/configs/model/job'
require 'travis/yml/configs/model/stage'
require 'travis/yml/helper/condition'

module Travis
  module Yml
    module Configs
      class Stages < Struct.new(:configs, :jobs, :data)
        # This will use the stage order defined in the :stages section, or an
        # empty array if none. Any stage names that not present in the stages
        # section, but are present in the jobs list, will be appended to the
        # stages section, i.e. sorted to the end of the list.

        include Model

        DEFAULT_STAGE = 'test'

        def apply
          assign_names && filter if stages?
          [stages.map(&:attrs), jobs.map(&:attrs)]
        end

        def assign_names
          jobs.inject(DEFAULT_STAGE) do |name, job|
            job.stage ||= name
          end
        end

        def filter
          @stages = stages.select { |stage| accept?(stage) }.reject { |stage| empty?(stage) }
          @jobs = jobs.select { |job| stages.map(&:name).include?(job.stage) }
        end

        def stages?
          !configs.empty? || !names.empty?
        end

        def accept?(stage)
          Condition.new(stage.attrs, data).accept?
        end

        def empty?(stage)
          jobs.none? { |job| job.stage == stage.name }
        end

        def jobs
          @jobs ||= super.map { |attrs| Job.new(attrs) }
        end

        def stages
          @stages ||= names.map { |name| stage(name) }
        end

        def stage(name)
          Stage.new(configs.detect { |attrs| attrs[:name] == name } || { name: name })
        end

        def names
          names = configs.map { |stage| stage[:name] }
          names = names + jobs.map(&:stage)
          names.compact.uniq
        end

        def configs
          @configs ||= Array(super).map do |config|
            config[:name] ||= DEFAULT_STAGE
            config
          end
        end
      end
    end
  end
end
