module Travis
  module Yml
    module Configs
      class Filter
        class Jobs < Struct.new(:config, :jobs, :data, :msgs)
          include Helper::Obj

          def apply
            @jobs = jobs.select do |job|
              accept?(job)
            end
          end

          def accept?(job, ix = 0)
            data = data_for(job)
            return true if Condition.new(job[:if], job, data).accept?
            msgs << [:info, key, :"skip_job", number: ix + 1, condition: job[:if]]
            false
          end

          def data_for(job)
            only(job, *%i(language os dist env)).merge(data)
          end
        end
      end
    end
  end
end
