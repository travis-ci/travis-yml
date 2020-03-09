# frozen_string_literal: true
require 'travis/yml/doc/value/factory'
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Default < Base
          include Value::Factory

          register :default

          def apply
            apply? && default? ? default : value
          end

          private

            def apply?
              enabled? && !value.map? && !schema.secure?
            end

            def default?
              schema.default? && value.missing? && supported&.value
            end

            def invalid_type?
              value.errored? && value.type != schema.type
            end

            def default
              default = supported&.value
              info :default, key: value.key, default: default, line: value.key.line, src: value.key.src
              build(value.parent, value.key, schema.seq? ? [default] : default, value.opts)
            end

            def supported?
              !!supported
            end

            def supported
              schema.defaults.detect do |default|
                support(default).supported?
              end
            end
            memoize :supported

            def support(default)
              support = schema.values.support(default.value)
              support = schema.defaults.support(default.value) if support.nil? || support.empty?
              Value::Support.new(support, supporting, default.value)
            end

            def defaults
              schema.defaults
            end

            def supporting
              value.supporting
            end

            def enabled?
              value.enabled?(:defaults)
            end

            def info(*args)
              node = value.parent
              node = node.parent if node.seq? && node.key == value.key
              node.info(*args)
            end
        end
      end
    end
  end
end
