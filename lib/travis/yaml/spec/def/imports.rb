require 'travis/yaml/spec/type/fixed'

module Travis
  module Yaml
    module Spec
      module Def
        class Imports < Type::Seq
          register :imports

          def define
            type :import
          end
        end

        class Import < Type::Map
          register :import

          def define
            prefix :source, type: :str
            map :source, to: :str
            map :mode,   to: :str, alias: %i(merge_mode)
          end
        end
      end
    end
  end
end
