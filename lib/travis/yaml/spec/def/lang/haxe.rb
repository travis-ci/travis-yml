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
            map :hxml, to: :seq
            map :neko, to: :str
          end
        end
      end
    end
  end
end
