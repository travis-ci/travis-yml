require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Haxe < Type::Lang
          register :haxe

          def define
            name :haxe
            matrix :haxe
            matrix :hxml, to: :seq
            map :neko, to: :scalar
          end
        end
      end
    end
  end
end
