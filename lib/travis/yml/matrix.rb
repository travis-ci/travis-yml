# frozen_string_literal: true

require 'travis/yml/helper/condition'
require 'travis/yml/helper/obj'

module Travis
  module Yml
    class Matrix < Obj.new(:config, :data)
      include Helper::Obj, Memoize

      DROP = %i(jobs import stages notifications version)

      def initialize(config, *)
        config = sort(config)
        super
      end

      def jobs
        jobs = expand                    # expand jobs from matrix expansion keys
        jobs = with_included(jobs)       # add jobs from jobs.include
        jobs = with_default(jobs)        # default job if no job has been generated so far
        jobs = with_shared(jobs)         # shared non-matrix keys from root, e.g. language
        jobs = with_global(jobs)         # inherit first value from matrix keys from root to jobs.include
        jobs = with_env(jobs)            # normalize env to arrays (still required?), add global env
        jobs = without_excluded(jobs)    # reject jobs matching jobs.exclude
        jobs = without_unsupported(jobs) # drop unsupported keys
        jobs = jobs.uniq                 # drop duplicate jobs
        jobs = filter(jobs)              # filter jobs based on condition
        jobs
      end
      alias rows jobs

      def axes
        keys
      end

      def msgs
        @msgs ||= []
      end

      private

        def expand
          jobs = wrap(values.inject { |lft, rgt| lft.product(rgt) } || [])
          jobs = jobs.map { |job| keys.zip(wrap(job).flatten).to_h }
          jobs
        end

        def with_included(jobs)
          single_matrix_job_expanded?(jobs) ? included : jobs + included
        end

        # If there's one job at this point, and it has single-entry expand
        # values, and we also have matrix includes, remove the job because it's
        # probably an unnecessary duplicate.
        def single_matrix_job_expanded?(jobs)
          return false if jobs.size != 1 || included.empty?
          only(jobs.first, *keys).values.all? { |value| wrap(value).size == 1 }
        end

        def with_default(jobs)
          jobs << shared if jobs.empty?
          jobs
        end

        def with_shared(jobs)
          jobs.map { |job| shared.merge(job) }
        end

        def shared
          @shared ||= config.select { |key, value| shared_key?(key) && !blank?(value) }
        end

        def with_global(jobs)
          jobs.map { |job| global.merge(job) }
        end

        def global
          only(config, *keys - [:env]).map { |key, value| [key, wrap(value).first] }.to_h
        end

        def with_env(jobs)
          jobs = with_env_arrays(jobs)
          jobs = with_global_env(jobs)
          with_first_env(jobs)
        end

        def with_env_arrays(jobs)
          jobs.each { |job| job[:env] = with_env_array(job[:env]) if job[:env] }
        end

        def with_env_array(env)
          case env
          when Hash  then compact(wrap(except(env, :global)))
          when Array then env.map { |env| with_env_array(env) }.flatten(1)
          else wrap(env)
          end
        end

        def with_global_env(jobs)
          jobs.each { |job| job[:env] = global_env.+(job[:env] || []).uniq } if global_env
          jobs
        end

        # The legacy implementation picked the first env var out of `env.jobs` to
        # jobs listed in `jobs.include` if they do not define a key `env` already.
        def with_first_env(jobs)
          jobs.each { |job| (job[:env] ||= []).concat([first_env]).uniq! unless job[:env] } if first_env
          jobs
        end

        def without_excluded(jobs)
          jobs.delete_if { |job| excluded?(job) }
        end

        def without_unsupported(jobs)
          jobs.map { |job| job.select { |key, value| supported?(job, key, value) }.to_h }
        end

        def included
          return [] unless config.is_a?(Hash) && config[:jobs].is_a?(Hash)
          jobs = [config[:jobs][:include] || []].flatten.select { |job| job.is_a?(Hash) }
          with_stages(jobs)
        end
        memoize :included

        def with_stages(jobs)
          jobs.inject(nil) do |stage, job|
            job[:stage] ||= stage if stage
            job[:stage] || stage
          end
          jobs
        end

        def excluded
          return [] unless config.is_a?(Hash) && config[:jobs].is_a?(Hash)
          [config[:jobs][:exclude] || []].flatten
        end

        def excluded?(job)
          excluded.any? do |excluded|
            next unless accept?(:exclude, :'jobs.exclude', excluded)
            except(excluded, :if).all? do |key, value|
              case key
              when :env
                # TODO this wouldn't have to be a special case if we'd match
                # for inclusion (see below)
                env = job[:env]
                env = env - (config[:env].is_a?(Hash) && config[:env][:global] || []) if env
                env == value
              else
                # TODO if this is a hash or array we should not match for
                # equality, but inclusion (partial job.exclude matching)
                wrap(job[key]) == wrap(value)
              end
            end
          end
        end

        # move this to Yml::Doc.supported?
        def supported?(job, key, value)
          supporting = stringify(only(job, :language, :os, :arch))
          support = Yml.expand.support(key.to_s)
          Yml::Doc::Value::Support.new(support, supporting, value).supported?
        end

        def filter(jobs)
          jobs.select { |job| accept?(:job, :'jobs.include', job) }
        end

        def accept?(type, key, config, ix = 0)
          data = data_for(config)
          return true unless data
          return true if Condition.new(config, data).accept?
          msgs << [:info, key, :"skip_#{type}", number: ix + 1, condition: config[:if]]
          false
        end

        def data_for(config)
          only(config, *%i(language os dist env)).merge(data) if data
        end

        def global_env
          config[:env] && config[:env].is_a?(Hash) && config[:env][:global]
        end

        def first_env
          case env = config[:env]
          when Array
            env.first
          when Hash
            env.fetch(:jobs, nil)&.first
          end
        rescue nil
        end

        def values
          values = only(config, *keys)
          values = values.map { |key, value| env_jobs(key, value) || value }
          values = values.map { |value| wrap(value) }
          values
        end

        def env_jobs(key, obj)
          obj[:jobs] if key == :env && obj.is_a?(Hash) && obj.key?(:jobs)
        end

        def keys
          compact(config).keys & expand_keys
        end
        memoize :keys

        def shared_key?(key)
          !expand_keys.include?(key) && !DROP.include?(key)
        end

        def expand_keys
          Yml.expand_keys + [:env] # TODO allow nested matrix expansion keys, like env.jobs
        end
        memoize :expand_keys

        def sort(config)
          config.sort_by { |key, _| expand_keys.index(key) || 99 }.to_h
        end

        def blank?(obj)
          case obj
          when Array, Hash, String then obj.empty?
          when NilClass then true
          else false
          end
        end

        def wrap(obj)
          obj.is_a?(Array) ? obj : [obj]
        end
    end
  end
end
