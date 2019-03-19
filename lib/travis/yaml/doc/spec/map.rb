# frozen_string_literal: true
require 'travis/yaml/doc/spec/node'
require 'travis/yaml/helper/common'
require 'travis/yaml/helper/merge'

module Travis
  module Yaml
    module Doc
      module Spec
        class Map < Node
          register :map

          attr_reader :map

          def initialize(parent, spec)
            super(parent, Helper::Common.except(spec, :map, :includes, :expand))
            @map = map_for(spec[:map])
          end

          def type
            :map
          end

          def [](key)
            map[key]
          end

          def keys
            map.keys
          end

          def key?(key)
            map.key?(key)
          end

          def mappings
            map.values
          end

          def aliases
            super.merge(mappings.map(&:aliases).inject({}, &:merge))
          end
          memoize :aliases

          def required
            mappings.select(&:required?)
          end
          memoize :required

          def required_keys
            required.map(&:key)
          end
          memoize :required_keys

          def all_keys
            keys = map.map { |key, node| [key, node.all_keys] }
            keys = keys + aliases.values.flatten
            keys.flatten.compact.uniq
          end
          memoize :all_keys

          def down_keys
            keys = mappings.map(&:down_keys).compact.uniq
            keys = keys.inject({}) { |all, keys| Helper::Merge.apply(all, keys) }
            Helper::Common.except(keys, *self.keys)
          end
          memoize :down_keys

          private

            def map_for(spec)
              Array(spec).inject({}) do |map, (key, value)|
                map[key] = Mapping.new(self, value)
                map
              end
            end
        end
      end
    end
  end
end
