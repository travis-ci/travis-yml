require 'travis/yaml/spec/def/jdks'
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Groovy < Type::Lang
          register :groovy

          def define
            name :groovy
            matrix :jdk, to: :jdks
          end
        end
      end
    end
  end
end
