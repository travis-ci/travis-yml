require 'travis/yaml/spec/type/fixed'
require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'

module Travis
  module Yaml
    module Spec
      module Def
        class Git < Type::Map
          register :git

          def define
            map :depth,      to: :scalar, default: 50
            map :submodules, to: :scalar, cast: :bool
            map :strategy,   to: :fixed, values: [:clone, :tarball]
          end
        end
      end
    end
  end
end
