require 'travis/yaml/spec/def/jdks'
require 'travis/yaml/spec/type/lang'
require 'travis/yaml/spec/type/map'

module Travis
  module Yaml
    module Spec
      module Def
        class Android < Type::Lang
          register :android

          def define
            name :android
            matrix :jdk, to: :jdks
            map :android, to: :android_config
          end
        end

        class AndroidConfig < Type::Map
          register :android_config

          def define
            map :components, to: :seq
            map :licenses,   to: :seq
          end
        end
      end
    end
  end
end
