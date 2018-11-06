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
              type :seq
            end
          end
        end
      end
    end
  end
end
