# frozen_string_literal: true
# require 'travis/yml/doc/helper/support'
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Flags < Base
          # include Helper::Support

          register :flags

          def apply
            flag? ? flag : value
          end

          private

            def flag?
              value.given? # && relevant?
            end

            def flag
              edge_key         if edge_key?
              edge_value       if edge_value?
              # flagged          if schema.flagged?
              deprecated       if deprecated?
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

            def edge_value?
              # schema.fixed? && !!schema.values.find { |v| v.edge? && v.value == value.value }
            end

            def edge_value
              value.info :edge, value: value.value
            end

            # def flagged
            #   value.info :flagged, given: value.key
            # end

            def deprecated?
              schema.deprecated?
            end

            def deprecated
              value.warn :deprecated, deprecation: schema.deprecated
            end

            def deprecated_key?
              schema.map? # && schema.deprecated_key?(value.key)
            end

            def deprecated_key
              value.keys.each do |key|
                next unless deprecation = schema.deprecated_key(key)
                value.warn :deprecated, deprecation: deprecation
              end
            end

            def deprecated_value?
              schema.enum? && value.str? && schema.values.deprecated?(value.value)
            end

            def deprecated_value
              value.warn :deprecated, deprecation: :deprecated_value, value: value.value
            end

            # def info
            #   deprecated_value? ? value.deprecated : schema.deprecated
            # end
        end
      end
    end
  end
end
