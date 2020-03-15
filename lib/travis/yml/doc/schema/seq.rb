# frozen_string_literal: true
require 'travis/yml/doc/schema/node'

module Travis
  module Yml
    module Doc
      module Schema
        class Seq < Node
          attr_accessor :schema

          def opts=(opts)
            @opts = opts
            schema.opts = merge(only(opts, :defaults), schema.opts)
          end

          def matches?(value)
            value.none? || matches_seq?(value)
          end

          def matches_seq?(value)
            value.seq? && value.all? { |value| schema.matches?(value) }
          end

          def type
            :seq
          end

          def default?
            schema&.default?
          end

          def default
            schema&.default
          end

          def all_keys
            schema.all_keys
          end

          def aliases
            [super, schema.aliases].flatten
          end
          memoize :aliases

          def supports
            merge(super, schema.supports)
          end
          memoize :supports

          def dup
            @schema = schema.dup if schema
            super
          end

          def to_h
            { type: type, schema: schema.to_h, opts: opts }
          end
        end
      end
    end
  end
end
