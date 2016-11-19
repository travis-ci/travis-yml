require 'travis/yaml/spec/type/conditions'

module Travis
  module Yaml
    module Spec
      module Type
        class Mappings
          include Helper::Common

          attr_reader :map

          def initialize
            @map = {}
          end

          def [](key)
            map[key]
          end

          def add(name, key, types)
            mapping = Mapping.new(key, types)
            map[name] ? merge(name, mapping) : set(name, mapping)
          end

          def spec
            map.dup.map { |key, mapping| [key, mapping.spec] }.to_h
          end

          private

            def merge(key, mapping)
              map[key].merge(mapping)
            end

            def set(key, mapping)
              map[key] = mapping
            end
        end
      end
    end
  end
end
