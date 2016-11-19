require 'travis/yaml/spec/def/lang/compilers'
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Cpp < Type::Lang
          register :cpp

          def define
            name :cpp, alias: :'c++'
            matrix :compiler, to: :compilers, required: true, on: %i(c cpp)
          end
        end
      end
    end
  end
end
