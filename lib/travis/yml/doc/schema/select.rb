module Travis
  module Yml
    module Doc
      module Schema
        class Select < Obj.new(:schema, :value)
          # This is used by Change::Any, and Validate::Any.
          #
          # It returns:
          #
          # * the first schema that is a :map, and has a required key that maps
          #   to an :enum with one value that matches the given value
          # * all normal schemas or
          # * all schemas
          #
          # The first case is used for selecting a deploy provider schema based
          # on the given :provider name.
          #
          # Most :any schemas have one normal form which should be used for both
          # normalization (changes) and validation.
          #
          # Some schemas have multiple normal forms. E.g. the :secure schema allows
          # a hash with a single key :secure, or a string.
          #
          # Some schemas do not have any normal forms, so Change tries all of
          # them, while Validate validates against the first one (which is not
          # quite ideal).

          def apply
            schemas = [required || normal].flatten
            schemas.any? ? schemas : schema.schemas
          end

          private

            def required
              return unless schema.detect?
              maps = select(schema, &:required?)
              maps.detect(&method(:requires?))
            end

            def requires?(map)
              map.required.any? do |key|
                next unless enum = map[key]
                enum.known?(value_for(key)) if enum.enum? && enum.size == 1
              end
            end

            def normal
              schema.select(&:normal?)
            end

            def value_for(key)
              case value.type
              when :map
                value[key]&.value
              when :seq
                nil
              else
                value&.value
              end
            end

            def select(schema, &block)
              case schema.type
              when :any
                schema.map { |schema| select(schema, &block) }.flatten
              when :seq
                [schema.schema] if schema.schema.map?
              when :map
                [schema]
              else
                []
              end
            end
        end
      end
    end
  end
end
