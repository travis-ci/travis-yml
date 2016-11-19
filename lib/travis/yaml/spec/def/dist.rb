require 'travis/yaml/spec/type/fixed'

module Travis
  module Yaml
    module Spec
      module Def
        class Dist < Type::Fixed
          register :dist

          def define
            default :precise
            downcase

            value :precise
            value :trusty
            value :osx, alias: %i(mac macos ios)
          end
        end
      end
    end
  end
end
