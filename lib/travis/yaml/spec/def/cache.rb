require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Cache < Type::Map
          register :cache

          TYPES = %i(apt bundler cargo ccache cocoapods packages pip)

          def define
            normalize :cache, types: TYPES

            TYPES.each do |type|
              map type, to: :scalar, cast: :bool
            end

            map :edge, to: :scalar, cast: :bool, edge: true
            map :directories, to: :seq
            map :timeout, to: :scalar
          end
        end
      end
    end
  end
end
