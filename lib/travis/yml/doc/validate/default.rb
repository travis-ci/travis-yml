# frozen_string_literal: true
# require 'travis/yml/doc/helper/support'
require 'travis/yml/doc/value/factory'
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Default < Base
          include Value::Factory
          # include Helper::Support

          register :default

          def apply
            apply? && default? ? default : value
          end

          private

            def apply?
              enabled? && !value.map? && !schema.secure?
            end

            def default?
              schema.defaults? && value.missing? && supported?
            end

            def invalid_type?
              value.errored? && value.type != schema.type
            end

            def default
              default = supported.value
              value.info :default, default: default
              build(value.parent, value.key, schema.seq? ? [default] : default, value.opts)
            end

            def supported?
              !!supported
            end

            def supported
              schema.defaults.detect { |value| support(value).supported? }
            end
            memoize :supported

            def support(value)
              support = schema.defaults.support(value.value)
              Value::Support.new(support, supporting, value.value)
            end

            def supporting
              value.supporting
            end

            def enabled?
              value.enabled?(:defaults)
            end
        end
      end
    end
  end
end
