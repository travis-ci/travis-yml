# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/value/cast'

module Travis
  module Yml
    module Doc
      module Change
        class Enable < Base
          def apply
            apply? ? enable : value
          end

          def apply?
            schema.change?(:enable)
          end

          def enable
            other = value
            other = Enable.new(schema, other).apply
            other = Normalize.new(schema, other).apply
            other
          end

          class Enable < Base
            def apply
              apply? && enable? ? enable : value
            end

            def apply?
              schema.map? && schema.key?(:enabled) && value.scalar? && !value.none?
            end

            def enable?
              !value.str? or value.value != casted
            end

            def enable
              other = value.serialize
              build(enabled: casted)
            end

            def casted
              @casted ||= Doc::Value::Cast.new(value.value, :bool).apply
            end
          end

          class Normalize < Base
            def apply
              apply? ? normalize : value
            end

            def apply?
              value.map? && value.key?(:disabled)
            end

            def normalize
              other = value.serialize.merge(enabled: enabled)
              other = compact(except(other, :disabled))
              build(other)
            end

            def enabled
              obj = value[:enabled]  and return cast(obj)
              obj = value[:disabled] and return !cast(obj)
              nil
            end
            memoize :enabled

            def cast(value)
              Doc::Value::Cast.new(value.value, :bool).apply
            end
          end
        end
      end
    end
  end
end
