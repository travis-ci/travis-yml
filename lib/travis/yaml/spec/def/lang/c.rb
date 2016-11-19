require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class C < Type::Lang
          register :c

          def define
            name :c
          end
        end
      end
    end
  end
end

