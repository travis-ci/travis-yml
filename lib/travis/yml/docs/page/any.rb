require 'travis/yml/docs/page/base'

module Travis
  module Yml
    module Docs
      module Page
        class Any < Base
          def pages
            pages = node.schemas.map { |node| build(node).pages }.flatten
            [self, *pages].select(&:publish?)
          end

          # def children
          #   normals = node.schemas.select(&:normal?)
          #   pages = normals.map { |node| build(node).pages }.flatten
          #   pages.map(&:children).flatten.compact.uniq
          # end

          def types
            node.expand
          end

          def display_types
            types.map { |node| build(node).display_type }.uniq
          end

          def enum
            node = types.detect { |schema| schema.type == :str }
            node.enum if node
          end

          def mappings
            return unless node = types.detect { |schema| schema.type == :map }
            node.mappings.map { |key, schema| [key, build(schema)] }.to_h
          end
        end
      end
    end
  end
end
