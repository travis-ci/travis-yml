require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Elm < Type::Lang
          register :elm

          def define
            name :elm
            matrix :elm

            map :elm_format, to: :str
            map :elm_test,   to: :str
          end
        end
      end
    end
  end
end
