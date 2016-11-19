require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Required < Conform
          register :required

          def apply?
            !node.present? && node.relevant? && node.required?
          end

          def apply
            node.parent.error :required, node.key
          end
        end
      end
    end
  end
end
