require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Dart < Type::Lang
          register :dart

          def define
            name :dart, alias: :dartlang
            matrix :dart
            map :with_content_shell, to: :bool
          end
        end
      end
    end
  end
end
