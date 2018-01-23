require 'travis/yaml/spec/type/fixed'

module Travis
  module Yaml
    module Spec
      module Def
        class Dist < Type::Fixed
          register :dist

          def define
            default :trusty
            downcase

            value :trusty
            value :precise
            value :osx, alias: %i(mac macos ios)
          end
        end
      end
    end
  end
end
