require 'travis/yaml/spec/def/lang/compilers'
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class C < Type::Lang
          register :c

          def define
            name :c
            matrix :compiler, to: :compilers, required: true, on: %i(c cpp)
          end
        end
      end
    end
  end
end

