require 'travis/yaml/doc/spec/node'

module Travis
  module Yaml
    module Doc
      module Spec
        class Lookup < Node
          register :lookup

          def type
            :loopup
          end

          def keys
            spec[:keys] || []
          end
        end
      end
    end
  end
end
