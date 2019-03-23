# frozen_string_literal: true
require 'travis/yaml/helper/common'
require 'travis/yaml/doc/value/support'
require 'travis/support/obj'

module Travis
  module Yaml
    module Helper
      module Lookup
        class Scalar < Obj.new(:spec, :node, :keys)
          def apply
            name && spec.types.detect { |spec| spec.name == name }
          end

          def name
            @name ||= node.value && node.value.to_s.to_sym
          end
        end

        class Map < Obj.new(:spec, :node, :keys)
          def apply
            name && spec.types.detect { |spec| spec.name == name }
          end

          def key
            @key ||= keys.detect { |key| node.key?(key) }
          end

          def name
            @name ||= begin
              name = node[key] && node[key].raw
              name.to_s.to_sym if name
            end
          end
        end

        TYPES = {
          scalar: Scalar,
          fixed:  Scalar,
          map:    Map
        }

        def self.apply(spec, node, keys)
          const = TYPES[node.type]
          const.new(spec, node, keys).apply if const
        end
      end
    end
  end
end
