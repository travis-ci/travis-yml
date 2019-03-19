# frozen_string_literal: true
require 'travis/yaml/helper/support'
require 'travis/yaml/support/obj'

module Travis
  module Yaml
    class Expand < Obj.new(:spec)
      def apply
        expand(spec)
      end

      private

        def expand(spec)
          spec[:type] == :map ? expand_map(spec) : expand_node(spec)
        end

        def expand_map(spec)
          map = with_includes(spec) || {}
          map = map.map { |key, value| [key, expand(value)] }.to_h
          spec.merge(map: map)
        end

        def expand_node(spec)
          spec[:types] ? spec.merge(types: expand_types(spec[:types])) : spec
        end

        def expand_types(types)
          types.map { |type| expand(type) }
        end

        def with_includes(spec)
          Array(spec[:include]).inject(spec[:map]) do |map, key|
            incl = self.spec[:includes][key]
            incl = incl[:map] if incl
            incl = Support.new(incl, expand: spec[:expand]).map if key == :support
            incl ? map.merge(incl) : map
          end
        end
    end
  end
end
