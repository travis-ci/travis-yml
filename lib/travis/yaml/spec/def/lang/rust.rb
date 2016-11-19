require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Rust < Type::Lang
          register :rust

          def define
            name :rust
            matrix :rust
          end
        end
      end
    end
  end
end
