# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class UnknownValue < Base
          register :unknown_value

          def apply
            apply? && unknown? ? unknown : value
          end

          private

            def apply?
              schema.enum? && value.scalar? && value.given?
            end

            def unknown?
              !schema.known?(value.value)
            end

            def unknown
              default ? unknown_default : unknown_value
            end

            def unknown_value
              value.error :unknown_value, value: value.value
              drop? ? none : value
            end

            def unknown_default
              value.warn :unknown_default, value: value.value, default: default
              value.set(default)
              value
            end

            def default
              schema.defaults.detect do |default|
                # Value::Support.new(value.supporting, default).supported?
                break default.value
              end
            end
            memoize :default

            def drop?
              value.drop?
            end
        end
      end
    end
  end
end
