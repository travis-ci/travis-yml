require 'travis/yaml/doc/type/node'

module Travis
  module Yaml
    module Doc
      module Type
        class Map < Node
          register :map

          def children
            @children ||= []
          end

          def [](key)
            child = child_for(key)
            child.serialize if child
          end

          def present?
            children.any?(&:present?)
          end

          def strict?
            opts.key?(:strict) ? !!opts[:strict] : true
          end

          def error(*)
            super
            drop
          end

          def drop
            children.clear
          end

          def serialize
            nodes = children.select(&:present?)
            return unless nodes.any?
            nodes.map { |child| [child.key, child.serialize] }.to_h
          end

          private

            def child_for(key)
              children.detect { |child| child.key == key }
            end
        end
      end
    end
  end
end
