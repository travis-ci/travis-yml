# frozen_string_literal: true
require 'travis/yaml/spec/type/conditions'
require 'travis/yaml/support/obj'

module Travis
  module Yaml
    module Spec
      module Type
        class Mappings < Obj.new(map: {})
          include Helper::Common

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
