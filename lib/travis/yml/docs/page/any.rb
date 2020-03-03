require 'travis/yml/docs/page/base'

module Travis
  module Yml
    module Docs
      module Page
        class Any < Base
          def id
            super || node.schemas.detect(&:id)&.id # ugh. notification anys do not have an id atm ...
          end

          def title
            super || node.schemas.detect(&:title)&.title # ugh. notification anys do not have a title atm ...
          end

          def types
            node.expand
          end

          def display_type
            types = display_types.map(&:first)
            types = [types[0..-2].join(', '), types[-1]].join(', or ')
            [types, nil]
          end

          def display_types
            types.map { |node| build(self, nil, node).display_type }.uniq
          end

          def enum
            types.detect(&:str?)&.enum
          end

          def prefix
            types.detect(&:map?)&.prefix unless id == :deploys
          end

          def mappings
            return unless map = types.detect(&:map?)
            map.mappings.map { |key, schema| [key, build(self, key, schema)] }.to_h
          end

          def includes
            return unless map = types.detect(&:map?)
            map.includes.map { |schema| build(self, nil, schema) }
          end

          def pages
            pages = node.schemas.map { |node| build(self, nil, node).pages }.flatten
            pages = [self, *pages].select(&:publish?)
            pages
          end

          def children
            [mappings&.values, includes].compact.flatten.select(&:publish?).reject(&:deprecated?)
          end

          def base_type?
            return true if super
            children.all?(&:base_type?)
          end
        end
      end
    end
  end
end
