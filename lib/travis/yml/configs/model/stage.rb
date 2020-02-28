module Travis
  module Yml
    module Configs
      module Model
        class Stage < Struct.new(:attrs)
          def name
            attrs[:name]
          end
        end
      end
    end
  end
end
