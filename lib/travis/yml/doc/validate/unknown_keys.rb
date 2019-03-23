# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class UnknownKeys < Base
          register :unknown_keys

          def apply
            return value unless apply?
            value.keys.inject(value) do |parent, key|
              next parent unless unknown?(parent[key])
              unknown(parent, key, parent[key])
            end
          end

          private

            def apply?
              value.map? && schema.map? && schema.strict? && value.given?
            end

            def unknown?(value)
              value && value.given? && !schema.key?(value.key)
            end

            def unknown(parent, key, value)
              type = misplaced?(key) ? :misplaced_key : :unknown_key
              warn(parent, type, value) unless silent?(key)
              parent.delete(value) if drop? || silent?(key)
              parent
            end

            def misplaced?(key)
              Yml.keys.include?(key)
            end

            def silent?(key)
               schema.silent?(key)
            end

            def drop?
              opts[:unknown_keys] == 'drop'
            end

            def warn(parent, type, value)
              parent.msg :warn, type, key: value.key, value: value.serialize
            end
        end
      end
    end
  end
end
