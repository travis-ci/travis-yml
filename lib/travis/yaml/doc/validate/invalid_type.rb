require 'travis/yaml/helper/common'
require 'travis/yaml/doc/helper/support'
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class InvalidType < Validator
          include Helper::Common, Helper::Support

          register :invalid_type

          NAMES = {
            NilClass:   :nil,
            TrueClass:  :bool,
            FalseClass: :bool,
            Fixnum:     :str,
            String:     :str,
            Regexp:     :str,
            Secure:     :secure,
            Hash:       :map,
            Array:      :seq,
          }

          def apply
            invalid? ? invalid : node
          end

          private

            def invalid?
              node.present? && relevant? && invalid_type?
            end

            def invalid
              node.error :invalid_type, expected: expected, actual: actual, value: value unless value.nil?
            end

            def strict?
              spec.strict?
            end

            def invalid_type?
              case spec.type
              when :map    then !node.map?
              when :seq    then !node.seq?
              when :secure then false
              else invalid_scalar?
              end
            end

            def invalid_scalar?
              strict? && !secure? && actual != spec.cast
            end

            def secure?
              node.secure?
            end

            def expected
              case spec.type
              when :map then :map
              when :seq then :seq
              else spec.cast
              end
            end

            def actual
              node.secure? ? :secure : NAMES[value.class.name.to_sym] || value.class.name
            end

            def value
              node.raw
            end
        end
      end
    end
  end
end
