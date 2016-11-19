require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Haskell < Type::Lang
          register :haskell

          def define
            name :haskell
            matrix :ghc
          end
        end
      end
    end
  end
end
