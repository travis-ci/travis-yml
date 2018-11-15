require 'travis/yaml/spec/type/fixed'
module Travis
  module Yaml
    module Spec
      module Def
        class Arch < Type::Fixed
          register :arch
          def define
            only os: :linux
            default :amd64
            downcase
            value   :amd64, alias: :x86_64
            value   :ppc64le, alias: %i(power ppc ppc64 ppc64el)
          end
        end
      end
    end
  end
end
