require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Cache < Type::Map
          register :cache

          TYPES = %i(apt bundler cargo ccache cocoapods npm packages pip yarn)

          def define
            change :cache, types: TYPES # really? enable all the caches?

            TYPES.each do |type|
              map type, to: :bool
            end

            map :edge, to: :bool, edge: true
            map :directories, to: :seq
            map :timeout, to: :str
            map :branch, to: :str
          end
        end
      end
    end
  end
end
