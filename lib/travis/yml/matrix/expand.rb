module Travis
  module Yml
    class Matrix
      class Expand < Obj.new(:config, :keys)
        # should be able to drop a lot of this once everyone's on /configs

        def jobs
          jobs = wrap(values.inject { |lft, rgt| lft.product(rgt) } || [])
          jobs = jobs.map { |job| keys.zip(wrap(job).flatten).to_h }
          jobs
        end

        private

          def values
            values = only(config, *keys)
            values = values.map { |key, value| env_jobs(key, value) || value }
            values = values.map { |value| wrap(value) }
            values
          end

          def env_jobs(key, obj)
            obj[:jobs] if key == :env && obj.is_a?(Hash) && obj.key?(:jobs)
          end

          def wrap(obj)
            obj.is_a?(Array) ? obj : [obj]
          end
      end
    end
  end
end
