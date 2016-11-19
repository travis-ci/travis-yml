require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Doc
      module Factory
        class Map < Struct.new(:spec, :value, :node)
          include Helper::Common

          def map_children
            mappings.each do |name, spec|
              value = self.value[name]
              key   = spec[:key] || name
              type  = Types.new(spec[:types], value).detect
              type  = with_opts(type, name, spec)
              node.children << Node.new(type, node, key, value).build
            end
          end

          def with_opts(type, name, spec)
            type = type.merge(only(self.spec, *Node::INHERIT))
            type = type.merge(only(spec, *Node::INHERIT))
            type = type.merge(given: true) if self.value.key?(name)
            type
          end

          def mappings
            maps = spec[:map] ? spec_mappings : {}
            maps = maps.merge(open_mappings(except(value, *maps.keys))) if value.is_a?(Hash)
            maps
          end

          def spec_mappings
            spec[:map].inject({}) do |maps, (key, map)|
              key = mapped_key(map)
              maps[key] = map.merge(known: true) if key
              maps
            end
          end

          def mapped_key(map)
            key = aliased_key(map)
            key ||= map[:key] if value.key?(map[:key])
            key ||= map[:key] if required?(map)
            key && key.to_sym
          end

          def aliased_key(map)
            key = mapped_alias(map) if aliases(map).any?
            node.info :alias, key.to_s, map[:key].to_s, map[:key].to_s if key
            key
          end

          def mapped_alias(map)
            aliases(map).detect { |key| value.key?(key.to_sym) }
          end

          def aliases(map)
            map[:types].map { |type| type[:alias] }.compact.flatten
          end

          def required?(map)
            map[:types].any? { |type| type[:required] }
          end

          def open_mappings(value)
            value.map { |key, value| [key, mapping_for(key, value)] }.to_h
          end

          def mapping_for(key, value)
            type = Types.new(spec[:types], value).detect
            mapping = { known: false }
            mapping = mapping.merge(types: [type.merge(strict: false)]) if type
            mapping
          end
        end
      end
    end
  end
end
