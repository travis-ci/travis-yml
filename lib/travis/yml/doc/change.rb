# frozen_string_literal: true
require 'travis/yml/doc/change/cache'
require 'travis/yml/doc/change/enable'
require 'travis/yml/doc/change/env_vars'
require 'travis/yml/doc/change/flatten'
require 'travis/yml/doc/change/inherit'
require 'travis/yml/doc/change/cast'
require 'travis/yml/doc/change/downcase'
require 'travis/yml/doc/change/keys'
require 'travis/yml/doc/change/pick'
require 'travis/yml/doc/change/prefix'
require 'travis/yml/doc/change/value'
require 'travis/yml/doc/change/wrap'

module Travis
  module Yml
    module Doc
      module Change
        extend self

        def apply(schema, value)
          # puts
          # p value.keys.map { |key| [key, key.line] } if value.map?
          # puts caller[0..5]
          other = build(schema, value).apply
          # p other.keys.map { |key| [key, key.line] } if other.map?
          other
        end

        def build(schema, value)
          case schema.type
          when :any    then Any.new(schema, value)
          when :seq    then Seq.new(schema, value)
          when :map    then Map.new(schema, value)
          when :secure then Secure.new(schema, value)
          else Scalar.new(schema, value)
          end
        end

        CHANGE = {
          all:    :all,
          any:    :any,
          schema: :map,
          map:    :map,
          seq:    :seq,
          none:   :obj,
          bool:   :obj,
          num:    :obj,
          str:    :obj,
          enum:   :obj,
          secure: :obj,
        }

        CHANGES = {
          all: [],
          any: [],
          map: [Keys, Cache, Enable, Prefix, Pick, Inherit],
          seq: [EnvVars, Flatten, Pick, Wrap],
          obj: [Pick, Cast, Downcase, Value],
        }

        class Node < Obj.new(:schema, :value, opts: {})
          def changes
            CHANGES[CHANGE[schema.type]] || raise("Unknown changes: #{type}")
          end

          def build(other)
            Doc::Value.build(value.parent, value.key, other, value.opts)
          end
        end

        class Any < Node
          def apply
            schemas = Schema.select(schema, value)
            schemas.detect do |schema|
              other = Change.apply(schema, value)
              break other if schema.normal? || schema.matches?(other)
            end || value
          end

          def schemas
            schemas = schema.select(&:normal?)
            schemas.any? ? schemas : schema.schemas
          end
        end

        class Seq < Node
          def apply
            other = changes.inject(value) do |value, change|
              value = change.new(schema, value, opts).apply
              value
            end
            other = change_items(schema.schema, other) if other.seq?
            other
          end

          def change_items(schema, value)
            value.map do |value|
              value = Change.apply(schema, value)
              value
            end
          end
        end

        class Map < Node
          def apply
            other = changes.inject(value) do |value, change|
              change.new(schema, value, opts).apply
            end
            other = Mappings.new(schema, other).apply if other.map?
            other
          end
        end

        class Mappings < Node
          def apply
            other = value.map do |key, value|
              child = schema[key] || schema.strict? ? schema[key] : schema.schema
              [key, child ? Change.apply(child, value) : value]
            end
            build(other.to_h)
          end
        end

        class Scalar < Node
          def apply
            changes.inject(value) do |value, change|
              change.new(schema, value, opts).apply
            end
          end
        end

        class Secure < Scalar
        end
      end
    end
  end
end
