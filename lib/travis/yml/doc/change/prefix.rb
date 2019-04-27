# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/helper/match'

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
            value.map? && value.key?(schema.prefix[:key])
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
            known, other = split(value.value, *schema.keys)
            other = build({ schema.prefix[:key] => other }.merge(known))
            matching(other)
          end

          def prefix_obj
            other = build(schema.prefix[:key] => value)
            matching(other)
          end

          def matching(other)
            other = Change.apply(schema, other) unless schema.matches?(other)
            schema.matches?(other) ? other : value
          end

          def keys(value)
            keys = schema.keys.map(&:to_s)
            keys = value.keys.map { |key| match(keys, key) || key }
            keys.map(&:to_sym)
          end

          def match(keys, key)
            Match.new(keys, key.to_s).run
          end
        end
      end
    end
  end
end
