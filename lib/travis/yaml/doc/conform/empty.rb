require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Empty < Conform
          register :empty

          def apply?
            node.given? && node.blank?
          end

          def apply
            node.parent.msg :error, :empty, node.key
            node.drop
          end
        end
      end
    end
  end
end
