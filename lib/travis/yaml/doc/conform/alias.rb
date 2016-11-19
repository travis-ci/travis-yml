require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Alias < Conform
          register :alias

          def apply?
            node.value.is_a?(String) && node.alias?
          end

          def apply
            node.info :alias, node.value, node.alias, node.alias
            node.value = node.alias
          end
        end
      end
    end
  end
end
