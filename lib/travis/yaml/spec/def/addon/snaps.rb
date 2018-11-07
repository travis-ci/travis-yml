require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Snaps < Type::Seq
            register :snaps

            def define
              type :scalar, :snap
            end
          end

          class Snap < Type::Map
            register :snap

            def define
              map :name, to: :str
              map :classic, to: :bool
              map :channel, to: :str
            end
          end
        end
      end
    end
  end
end
