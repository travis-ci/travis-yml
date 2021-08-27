require 'travis/yml/helper/condition'

module Travis
  module Yml
    module Configs
      class Filter
        class Env < Obj.new(:config, :jobs, :data, :repo, :msgs)
          def apply
            @config = config.merge(env: filter_config(config[:env])) if config.key?(:env)
            @jobs = filter_jobs(jobs)
          end

          private

          def filter_config(config)
            case config
            when Array
              config.map(&method(:filter_config))
            when Hash
              config.each_with_object({}) do |(k, v), memo|
                memo[k] = filter_config(v) if accept?(k, v)
              end
            else
              config
            end
          end

          def filter_jobs(config)
            jobs.map do |job|
              if job.key?(:env)
                job[:env] = filter_config(job[:env])
              end

              job
            end
          end

          def compact(obj)
            case obj
            when Array then obj.compact
            when Hash then obj.reject { |k, v| v.nil? }
            else obj
            end
          end

          def present?(obj)
            case obj
            when Hash then !obj.empty?
            else true
            end
          end

          def accept?(key, value)
            return false if key == :secure && data.key?(:head_repo) && data[:head_repo] != repo.slug

            true
          end
        end
      end
    end
  end
end
