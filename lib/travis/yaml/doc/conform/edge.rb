require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Edge < Conform
          register :edge

          def apply?
            node.present? && node.relevant? && node.edge?
          end

          def apply
            node.info :edge, node.key
          end
        end
      end
    end
  end
end
