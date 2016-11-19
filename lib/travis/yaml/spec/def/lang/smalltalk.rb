require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Smalltalk < Type::Lang
          register :smalltalk

          def define
            name :smalltalk
            matrix :smalltalk
            map :smalltalk_config, to: :scalar
          end
        end
      end
    end
  end
end
