# frozen_string_literal: true
require 'travis/yaml/doc/validate/validator'
require 'travis/yaml/doc/value/support'

module Travis
  module Yaml
    module Doc
      module Validate
        class UnsupportedValue < Validator
          register :unsupported_value

          def apply
            incompatible? ? incompatible : node
          end

          private

            def incompatible?
              spec.fixed? && node.scalar? && !support.supported?
            end

            def incompatible
              support.msgs.inject(node) do |node, msg|
                node.error :unsupported, msg.merge(key: node.key, value: node.raw)
              end
            end

            def support
              @support ||= Value::Support.new(node.supporting, value ? value.opts : {})
            end

            def value
              @values ||= spec.values.detect { |value| value == node.value }
            end
        end
      end
    end
  end
end
