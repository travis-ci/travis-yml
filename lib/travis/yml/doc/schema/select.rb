require 'travis/yml/doc/helper/match'

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
            schemas = [detect || normal].flatten
            schemas.any? ? schemas : schema.schemas
          end

          private

            def detect
              return unless schema.detect?
              schema.detect do |schema|
                maps(schema).detect(&method(:applies?))
              end
            end

            def applies?(map)
              key = schema.opts[:detect].to_s
              return unless enum = map[key]
              return unless enum.enum? && enum.size == 1
              return unless str = value_for(enum, key)
              return unless str.is_a?(String)
              return unless enum.known?(str) || enum.known?(match(enum, str))
              # hmm. this is so msgs can include the :provider key without
              # having to pass this everytime we create a msg
              value.opts[:detected] = key
              true
            end

            def normal
              schema.select(&:normal?)
            end

            def value_for(enum, key)
              case value.type
              when :map
                value[key]&.value
              when :seq
                nil
              else
                value&.value
              end
            end

            def match(enum, str)
              schema.match(enum.values.map(&:value), str)
            end

            def maps(schema)
              case schema.type
              when :any
                schema.map { |schema| maps(schema) }.flatten
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
