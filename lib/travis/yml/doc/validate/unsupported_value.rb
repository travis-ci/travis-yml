# frozen_string_literal: true
require 'travis/yml/doc/validate/base'
require 'travis/yml/doc/value/support'

module Travis
  module Yml
    module Doc
      module Validate
        class UnsupportedValue < Base
          register :unsupported_value

          def apply
            unsupported if apply?
            value
          end

          private

            def apply?
              schema.enum? && value.scalar? && support
            end

            def unsupported
              support.msgs.each do |msg|
                value.warn :unsupported, msg.merge(key: value.key, value: value.serialize)
              end
            end

            def support
              return unless support = schema.values.support(value.value)
              Value::Support.new(support, value.supporting, value.value)
            end
            memoize :support
        end
      end
    end
  end
end
