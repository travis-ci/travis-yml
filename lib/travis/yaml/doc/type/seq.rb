require 'travis/yaml/doc/type/node'

module Travis
  module Yaml
    module Doc
      module Type
        class Seq < Node
          register :seq

          def children
            @children ||= []
          end

          def present?
            children.any?(&:present?)
          end

          def serialize
            children.map(&:serialize).compact
          end

          def error(*)
            super
            drop
          end

          def drop
            children.clear
          end
        end
      end
    end
  end
end
