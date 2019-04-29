# frozen_string_literal: true
require 'travis/yml/doc/change/base'

module Travis
  module Yml
    module Doc
      module Change
        class Repair < Base
          def apply
            # repair? ? repair : value
            value
          end

          private

            def repair?
              parent&.seq? &&   # parent's parent is a seq??
              value.map? &&     # value is a map
              schema.scalar? && # schema wants a scalar
              single_value? &&  # hash contains a single value that is a string or nil
              schema.strict? && # not an open map
              special_chars?    # key contains schemaial chars
            end

            def repair
              # YAML removes extra whitespace before the colon, but we know
              # there must have been whitespace after the colon.
              repaired = [key, value].to_a.flatten.join(': ').strip
              parent.warn :repair, key: key, value: value, to: repaired
              build(repaired)
            end

            def parent
              value.parent
            end

            def single_value?
              return false unless value.size == 1
              value.is_a?(String) || value.nil?
            end

            def special_chars?
              !key.to_s.scan(/[^\w\-\.]/).empty?
            end

            def key
              @key ||= value.keys.first.to_s
            end

            def value
              @value ||= value.values.first.raw
            end
        end
      end
    end
  end
end
