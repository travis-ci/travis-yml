require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Hack < Type::Lang
          register :hack

          def define
            name :hack
            matrix :hhvm
            matrix :php
          end
        end
      end
    end
  end
end
