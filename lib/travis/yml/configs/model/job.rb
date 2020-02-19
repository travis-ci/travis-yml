module Travis
  module Yml
    module Configs
      module Model
        class Job < Struct.new(:attrs)
          def [](key)
            attrs[key]
          end

          def stage
            attrs[:stage]
          end

          def stage=(stage)
            attrs[:stage] = stage
          end

          def allow_failure?
            !!attrs[:allow_failure]
          end

          def allow_failure=(allow_failure)
            attrs[:allow_failure] = allow_failure
          end
        end
      end
    end
  end
end
