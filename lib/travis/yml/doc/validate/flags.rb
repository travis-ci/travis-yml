# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Flags < Base
          register :flags

          def apply
            flag? ? flag : value
          end

          private

            def flag?
              value.given?
            end

            def flag
              edge_key         if edge_key?
              deprecated_key   if deprecated_key?
              deprecated_value if deprecated_value?
              value
            end

            def edge_key?
              schema.edge?
            end

            def edge_key
              value.info :edge
            end

            def deprecated_value?
              schema.enum? && value.str? && schema.values.deprecated?(value.value)
            end

            def deprecated_value
              deprecation = schema.values.deprecation(value.value)
              value.warn :deprecated_value, value: value.value, info: deprecation
            end

            def deprecated_key?
              schema.map? && value.map?
            end

            def deprecated_key
              value.keys.each do |key|
                next unless deprecation = schema[key]&.deprecation
                value.warn :deprecated_key, key: key, info: deprecation, line: key.line, src: key.src
              end
            end
        end
      end
    end
  end
end
