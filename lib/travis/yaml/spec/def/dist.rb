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
            value :xenial
            value :osx, alias: %i(mac macos ios)
            value :'server-2016', edge: true
          end
        end
      end
    end
  end
end
