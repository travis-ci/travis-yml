require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Crystal < Type::Lang
          register :crystal

          def define
            name :crystal
            matrix :crystal
          end
        end
      end
    end
  end
end
