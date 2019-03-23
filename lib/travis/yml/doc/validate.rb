# frozen_string_literal: true
require 'travis/yml/doc/validate/alert'
require 'travis/yml/doc/validate/compact'
require 'travis/yml/doc/validate/condition'
require 'travis/yml/doc/validate/default'
require 'travis/yml/doc/validate/empty'
require 'travis/yml/doc/validate/flags'
require 'travis/yml/doc/validate/format'
require 'travis/yml/doc/validate/invalid_type'
require 'travis/yml/doc/validate/required'
require 'travis/yml/doc/validate/template'
require 'travis/yml/doc/validate/unique'
require 'travis/yml/doc/validate/unknown_keys'
require 'travis/yml/doc/validate/unknown_value'
require 'travis/yml/doc/validate/unsupported_keys'
require 'travis/yml/doc/validate/unsupported_value'

module Travis
  module Yml
    module Doc
      module Validate
        extend self

        def apply(schema, value)
          build(schema, value).apply
        end

        def build(schema, value)
          case schema.type
          when :any then Any.new(schema, value)
          when :seq then Seq.new(schema, value)
          when :map then Map.new(schema, value)
          else Obj.new(schema, value)
          end
        end

        VALIDATE = {
          schema: :map,
          map:    :map,
          seq:    :seq,
          none:   :obj,
          bool:   :obj,
          num:    :obj,
          str:    :obj,
          enum:   :obj,
          secure: :obj
        }

        VALIDATORS = {
          map: [
            InvalidType, UnknownKeys, UnsupportedKeys, Compact, Required, Empty
          ],
          seq: [
            InvalidType, Compact, Empty, Unique
          ],
          obj: [
            InvalidType, UnknownValue, UnsupportedValue, Default, Alert, Flags,
            Format, Condition, Template
          ]
        }

        class Node < Obj.new(:schema, :value, opts: {})
          def validate(schema, value)
            validators(schema).inject(value) do |value, const|
              value = const.new(schema, value, {}).apply
              value
            end
          end

          def validators(schema)
            VALIDATORS[VALIDATE[schema.type]] || raise("Unknown validators: #{schema.type}")
          end

          def build(other)
            Doc::Value.build(value.parent, value.key, other, value.opts)
          end
        end

        class Any < Node
          def apply
            schemas = Schema.select(schema, value)
            child = schemas.detect { |schema| schema.matches?(value) } || schemas.first
            Validate.apply(child, value)
          end
        end

        class Seq < Node
          def apply(value = self.value)
            value = items(schema.schema, value) if value.seq?
            value = validate(schema, value)
            value
          end

          def items(schema, value)
            value.map do |value|
              Validate.apply(schema, value)
            end
          end
        end

        class Map < Node
          def apply(value = self.value)
            value = mappings if value.map?
            value = validate(schema, value)
            value
          end

          def mappings
            value.keys.inject(value) do |map, key|
              next map unless schema.map[key]
              value = map[key] || Value.build(map, key, nil)
              value = Validate.apply(schema.map[key], value)
              value.parent[key] = value
              value.parent
            end
          end
        end

        class Obj < Node
          def apply
            validate(schema, value)
          end
        end
      end
    end
  end
end
