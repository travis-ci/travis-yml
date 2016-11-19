require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Pick < Conform
          register :pick

          def apply?
            node.value.is_a?(Array) && !!node.value.first
          end

          def apply
            node.warn :invalid_seq, node.value.first
            node.value = node.value.first
          end
        end
      end
    end
  end
end
