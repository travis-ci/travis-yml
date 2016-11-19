require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Doc
      module Factory
        class Types < Struct.new(:types, :value)
          include Helper::Common

          def detect
            type = match if types
            type = lookup(type) if lookup?(type)
            type ||= types.detect { |type| !lookup?(type) } if types
            type || infer
          end

          private

            def lookup?(type)
              type && type[:type] == :lookup
            end

            def match
              types.detect do |type|
                type[:type] == :lookup || type[:type] == infer[:type]
              end
            end

            def lookup(type)
              key = type[:keys].detect { |key| value[key] }
              return unless value[key]
              name = value[key].to_sym
              types.detect { |type| type[:name] == name }
            end

            def infer
              @infered ||= case value
              when Hash  then { type: :map, strict: false }
              when Array then { type: :seq }
              else            { type: :scalar }
              end
            end
        end
      end
    end
  end
end
