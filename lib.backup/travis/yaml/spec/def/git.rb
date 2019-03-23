# frozen_string_literal: true
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
            map :strategy,         to: :fixed, values: [:clone, :tarball]
            map :quiet,            to: :bool
            map :depth,            to: :str, default: 50
            map :submodules,       to: :bool
            map :submodules_depth, to: :str
          end
        end
      end
    end
  end
end
