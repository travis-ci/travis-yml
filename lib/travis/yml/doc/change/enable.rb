# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/helper/cast'

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
              schema.map? && schema.key?('enabled') && value.scalar? && !value.none?
            end

            def enable?
              value.bool? || %w(yes no).include?(value.value)
            end

            def enable
              build('enabled' => casted)
            end

            def casted
              @casted ||= Doc::Cast.new(value.value, :bool).apply
            end
          end

          class Normalize < Base
            def apply
              apply? ? normalize : value
            end

            def apply?
              value.map? && value.key?('disabled')
            end

            def normalize
              other = value.value.merge('enabled' => enabled)
              other = compact(except(other, 'disabled'))
              build(other)
            end

            def enabled
              obj = value['enabled']  and return cast(obj)
              obj = value['disabled'] and return !cast(obj)
              nil
            end
            memoize :enabled

            def cast(value)
              Doc::Cast.new(value.value, :bool).apply
            end
          end
        end
      end
    end
  end
end
