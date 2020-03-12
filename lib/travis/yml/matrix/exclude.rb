module Travis
  module Yml
    class Matrix
      class Exclude < Obj.new(:config, :job, :accept)
        def exclude?
          excludes.any? { |exclude| applies?(exclude) }
        end

        private

          def applies?(exclude)
            exclude.all? do |key, value|
              case key
              when :env then env == value
              when :stage then stage?(value)
              else wrap(job[key]) == wrap(value)
              end
            end
          end

          # TODO this wouldn't have to be a special case if we'd match
          # for inclusion, no equality on job.exclude
          def env
            env = job[:env]
            env = env - (config[:env].is_a?(Hash) && config[:env][:global] || []) if env
            env = env - config[:global_env] if config[:global_env].is_a?(Array)
            env
          end

          def stage?(name)
            job[:stage] == name || job[:stage].nil? && name.downcase == 'test'
          end

          def excludes
            return [] unless config.is_a?(Hash) && config[:jobs].is_a?(Hash)
            configs = [config[:jobs][:exclude] || []].flatten
            configs = configs.select { |config| config.is_a?(Hash) }
            configs = configs.select { |config| accept?(config) }
            configs.map { |config| except(config, :if) }
          end

          def accept?(config)
            accept.call(:exclude, :'jobs.exclude', config[:if], job)
          end

          def wrap(obj)
            obj.is_a?(Array) ? obj : [obj]
          end
      end
    end
  end
end
