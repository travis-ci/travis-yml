require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Flagged < Conform
          register :flagged

          def apply?
            node.present? && node.relevant? && node.flagged?
          end

          def apply
            node.info :flagged, node.key
          end
        end
      end
    end
  end
end
