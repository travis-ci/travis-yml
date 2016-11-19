require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Nix < Type::Lang
          register :nix

          def define
            name :nix
          end
        end
      end
    end
  end
end
