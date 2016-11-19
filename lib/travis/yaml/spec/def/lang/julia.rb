require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Julia < Type::Lang
          register :julia

          def define
            name :julia
            matrix :julia
          end
        end
      end
    end
  end
end
