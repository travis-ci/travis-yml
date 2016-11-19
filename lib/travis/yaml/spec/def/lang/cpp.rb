require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Cpp < Type::Lang
          register :cpp

          def define
            name :cpp, alias: :'c++'
          end
        end
      end
    end
  end
end
