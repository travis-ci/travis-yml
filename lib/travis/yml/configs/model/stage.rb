module Travis
  module Yml
    module Configs
      module Model
        class Stage < Struct.new(:attrs)
          def name
            attrs[:name]
          end

          def includes?(job)
            name.downcase == job.stage.downcase
          end

          def ==(other)
            name.downcase == other.name.downcase
          end
          alias :eql? :==

          def hash
            name.downcase.hash
          end
        end
      end
    end
  end
end
