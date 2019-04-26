# frozen_string_literal: true
require 'travis/yml/doc/change/cache'
require 'travis/yml/doc/change/enable'
require 'travis/yml/doc/change/env_vars'
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
          other = build(schema, value).apply
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
          seq: [Pick, Wrap, EnvVars],
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
              # if schema.seq?
              #   puts
              #   p schema.type
              #   p other.serialize
              #   p schema.matches?(other)
              #   p schema.normal?
              # end
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
              value = change_items(schema.schema, value) if value.seq?
              value
            end
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
          # Should see if we can make all changes recurse (like Pick and Inherit currently do)
          # by the way of doing something like:
          #
          #   def change(value)
          #     changes.inject(value) do |value, const|
          #       other = const.new(schema, value, opts).apply
          #       other = change(other) unless other == value
          #       other
          #     end
          #   end

          def apply
            changes.inject(value) do |value, change|
              change.new(schema, value, opts).apply
            end
          end
        end

        class Secure < Scalar
        end

        # module Report
        #   def self.included(const)
        #     const.extend Module.new {
        #       def report(name)
        #         prepend Module.new {
        #           define_method(name) do |*args|
        #             self.level += 1
        #             Report.new(self, :before, name).report
        #             super(*args).tap do |other|
        #               Report.new(self, :after, name, other).report
        #               self.ix += 1
        #               self.level -= 1
        #             end
        #           end
        #         }
        #       end
        #     }
        #   end
        #
        #   attr_writer :level, :ix
        #
        #   def level
        #     @level ||= parent ? parent.level : 0
        #   end
        #
        #   def ix
        #     @ix ||= 0
        #   end
        #
        #   class Report < Struct.new(:change, :stage, :name, :other)
        #     def report
        #       parts = [' ' * (change.level * 2)]
        #       parts << schema.object_id.to_s[-3, 3]
        #       parts << "#{green("#{type}#{".#{change.ix}" if change.is_a?(Any)}")}"
        #       parts << " #{stage}: #{name} schema"
        #       parts << blue("id=#{schema.id}") if schema.id
        #       parts << "key=#{schema.key}"
        #       parts << "(normal)" if schema.normal?
        #       parts << "wants #{blue(schema.type.inspect)}, value is #{blue(value.type.inspect)} #{value.serialize.inspect}."
        #       parts << "schema #{schema.matches?(value) ? green('matches!') : red('does not match')}" if stage == :after
        #       puts parts.join(' ')
        #     end
        #
        #     def schema
        #       change.schema
        #     end
        #
        #     def value
        #       change.value
        #     end
        #
        #     def type
        #       change.class.name.split('::').last
        #     end
        #
        #     def red(str);       "\e[31m#{str}\e[0m" end
        #     def green(str);     "\e[32m#{str}\e[0m" end
        #     def blue(str);      "\e[34m#{str}\e[0m" end
        #     def magenta(str);   "\e[35m#{str}\e[0m" end
        #     def cyan(str);      "\e[36m#{str}\e[0m" end
        #     def gray(str);      "\e[37m#{str}\e[0m" end
        #
        #     def bold(str);      "\e[1m#{str}\e[22m" end
        #     def underline(str); "\e[4m#{str}\e[24m" end
        #   end
        # end
      end
    end
  end
end
