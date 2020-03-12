# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class UnknownKeys < Base
          register :unknown_keys

          IGNORE = %w(merge_mode)

          def apply
            return value unless apply?
            value.keys.inject(value) do |map, key|
              next map if schema.custom?(key)
              value = map[key]
              next map unless unknown?(value)
              type = map.anchor?(key) ? :anchor : :unknown
              send(type, map, key, value)
              map
            end
          end

          private

            def apply?
              value.map? && schema.map? && schema.strict? && value.given?
            end

            def unknown?(value)
              value && value.given? && !schema.key?(value.key) && !ignore?(value.key)
            end

            def ignore?(key)
              IGNORE.include?(key)
            end

            def anchor(map, key, value)
              warn_anchor(map, value)
            end

            def unknown(map, key, value)
              warn_unknown(map, value)
              map.delete(value) if drop?
            end

            def warn_unknown(map, value)
              map.msg :warn, :unknown_key, key: value.key, value: value.serialize,
                line: value.key.line, src: value.key.src
            end

            def warn_anchor(map, value)
              map.msg :warn, :deprecated_key, key: value.key, info: 'anchor on a non-private key',
                line: value.key.line, src: value.key.src
            end

            def drop?
              value.drop?
            end
        end
      end
    end
  end
end
