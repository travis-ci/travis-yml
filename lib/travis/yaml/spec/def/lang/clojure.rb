require 'travis/yaml/spec/def/jdks'
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Clojure < Type::Lang
          register :clojure

          def define
            name :clojure
            matrix :jdk, to: :jdks
            map :lein, to: :str
          end
        end
      end
    end
  end
end
