# frozen_string_literal: true
module Travis
  module Yaml
    module Helper
      module Merge
        extend self

        def apply(one, other)
          case one
          when Hash  then on_map(one, other)
          when Array then on_seq(one, other)
          else on_scalar(one, other)
          end
        end

        def on_map(one, other)
          return one unless other.is_a?(Hash)
          keys = one.keys
          keys = keys + other.keys if other.is_a?(Hash)
          keys.uniq.map { |key| [key, apply(one[key], other[key])] }.to_h
        end

        def on_seq(one, other)
          case other
          when Array then one + other
          else one.+([other]).compact.uniq
          end
        end

        def on_scalar(one, other)
          one.nil? ? other : one
        end
      end
    end
  end
end
