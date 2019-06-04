# frozen_string_literal: true
require 'travis/yml/doc/change/base'

module Travis
  module Yml
    module Doc
      module Change
        class Prefix < Base
          def apply
            other = apply? && prefix? ? prefix : value
            other
          end

          def apply?
            schema.map? && schema.prefix?
          end

          def prefix?
            schema.prefix? && !prefixed? && matches? && value.given?
          end

          def prefixed?
            value.map? && value.key?(key)
          end

          def matches?
            types = schema.prefix[:only]
            types.nil? || types.any? { |type| value.is?(type) }
          end

          def prefix
            value.map? ? prefix_map : prefix_obj
          end

          def prefix_map
            return value if value.keys.all? { |key| schema.known?(key) }
            other, known = split(value.value, *schema.keys)
            other = build({ key => other }.merge(known))
            matching(other)
          end

          def prefix_obj
            other = build(key => value)
            matching(other)
          end

          def matching(other)
            other = Change.apply(schema, other) unless schema.matches?(other)
            schema.matches?(other) ? other : value
          end

          def keys(value)
            keys = schema.keys.map(&:to_s)
            keys = value.keys.map { |key| schema.match(keys, key) || key }
            keys
          end

          def key
            schema.prefix[:key].to_s
          end
        end
      end
    end
  end
end
