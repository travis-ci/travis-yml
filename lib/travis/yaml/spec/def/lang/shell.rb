require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Shell < Type::Lang
          register :shell

          def define
            name :shell, alias: %i(generic bash sh)
          end
        end
      end
    end
  end
end
