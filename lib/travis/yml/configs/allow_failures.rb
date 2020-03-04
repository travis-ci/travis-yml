require 'travis/yml/configs/model/job'
require 'travis/yml/helper/condition'
require 'travis/yml/helper/obj'

module Travis
  module Yml
    module Configs
      class AllowFailures < Struct.new(:config, :jobs, :data)
        include Helper::Obj

        DEFAULT_STAGE = 'test'

        def apply
          allow_failures
          jobs.map(&:attrs)
        end

        def allow_failures
          configs.each do |config|
            select(config).each do |job|
              allow_failure(config, job)
            end
          end
        end

        def allow_failure(config, job)
          if accept?(config, job.attrs || {})
            job.allow_failure = true
          else
            # TODO generate a message
          end
        end

        def accept?(config, job)
          Condition.new(config, job.merge(data)).accept?
        end

        def select(config)
          jobs.select { |job| matches?(config, job) }
        end

        def matches?(config, job)
          except(config, :if).all? do |key, value|
            case key
            when :branch
              # TODO deprecated in favor of conditional allow_failures
              data[:branch ] == value
            when :env
              # TODO this wouldn't have to be a special case if we'd match
              # for inclusion (see below)
              matches_env?(job[key], config[key])
            else
              # TODO if this is a hash or array we should not match for
              # equality, but inclusion (partial allow_failure matching)
              job[key] == config[key]
            end
          end
        end

        def matches_env?(lft, rgt)
          return false unless lft
          global = config[:env].is_a?(Hash) && config[:env][:global] || []
          lft = lft - global if lft
          return true if lft == rgt
          others = rgt - lft
          # this is not accurate, but tries to work around the fact that
          # env.jobs and env.global have been clobbered during matrix expansion
          # and we can now no longer know the original per-jobs vars
          others.all? { |var| global.include?(var) }
        end

        def jobs
          @jobs ||= super.map { |attrs| Model::Job.new(attrs) }
        end

        def configs
          @configs ||= Array(config.dig(:jobs, :allow_failures)).select do |config|
            config.is_a?(Hash)
          end
        end
      end
    end
  end
end

