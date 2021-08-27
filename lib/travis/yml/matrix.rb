# frozen_string_literal: true

require 'travis/yml/helper/condition'
require 'travis/yml/helper/obj'
require 'travis/yml/matrix/env'
require 'travis/yml/matrix/expand'
require 'travis/yml/matrix/exclude'
require 'travis/yml/matrix/support'

module Travis
  module Yml
    class Matrix
      include Helper::Obj, Memoize

      DROP = %i(jobs import stages notifications version allow_failure global_env merge_mode)

      attr_reader :config, :data

      def initialize(config, data)
        @config = sort(config)
        @data = compact(data)
      end

      def jobs
        jobs = expand                    # expand jobs from matrix expansion keys
        jobs = with_included(jobs)       # add jobs from jobs.include
        jobs = with_default(jobs)        # default job if no job has been generated so far
        jobs = with_shared(jobs)         # inherit shared non-matrix keys from root, e.g. language
        jobs = with_global(jobs)         # inherit the first value from matrix keys from root to jobs.include
        jobs = with_env(jobs)            # normalize env to arrays (still required?), add global env
        jobs = without_excluded(jobs)    # reject jobs matching jobs.exclude
        jobs = without_unsupported(jobs) # unset unsupported keys
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
          Expand.new(config, keys).jobs
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

        def with_global(jobs)
          jobs.map { |job| global.merge(job) }
        end

        def shared
          @shared ||= config.select { |key, value| shared_key?(key) && !blank?(value) }
        end

        def global
          @global ||= only(config, *keys - [:env]).map { |key, value| [key, wrap(value).first] }.to_h
        end

        def with_env(jobs)
          Env.new(config, data, jobs).apply
        end

        def without_excluded(jobs)
          jobs.delete_if { |job| Exclude.new(config, job, method(:accept?)).exclude? }
        end

        def without_unsupported(jobs)
          jobs.map { |job| job.select { |key, value| support(job, key, value).supported? }.to_h }
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

        def filter(jobs)
          jobs.select { |job| accept?(:job, :'jobs.include', job[:if], job) }
        end

        def accept?(type, key, cond, job, ix = 0)
          return true unless data
          return true if Condition.new(cond, job, data).accept?
          msgs << [:info, key, :"skip_#{type}", number: ix + 1, condition: cond]
          false
        # do we actually ever get here?
        rescue InvalidCondition => e
          Raven.capture_exception(e, extra: { type: type, condition: cond, data: data }) if defined?(Raven)
          false
        end

        def keys
          keys = compact(config).keys & expand_keys
          keys.select { |key| support(config, key).supported_key? }
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

        def support(job, key, value = true)
          Support.new(job, key, value)
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
