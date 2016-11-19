require 'travis/yaml/doc/validate/validator'
require 'travis/yaml/doc/helper/match'
require 'travis/yaml/helper/memoize'

module Travis
  module Yaml
    module Doc
      module Validate
        class UnknownValue < Validator
          register :unknown_value

          def apply
            unknown? ? unknown : node
          end

          private

            def unknown?
              spec.fixed? && string? && !values.include?(node.value)
            end

            def unknown
              default ? unknown_default : unknown_value
            end

            def unknown_value
              node.error :unknown_value, value: node.value
            end

            def unknown_default
              node.warn :unknown_default, value: node.value, default: default[:value]
              node.set(default[:value])
            end

            def string?
              node.scalar? && node.value.is_a?(String)
            end

            def values
              @values ||= spec.values.map(&:known).flatten
            end

            def default
              @default ||= spec.defaults.detect do |default|
                Value::Support.new(node.supporting, default).supported?
              end
            end
        end
      end
    end
  end
end
