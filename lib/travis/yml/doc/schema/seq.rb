# frozen_string_literal: true
require 'travis/yml/doc/schema/node'

module Travis
  module Yml
    module Doc
      module Schema
        class Seq < Node
          include Enumerable

          attr_accessor :schema

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

          def to_h
            { type: type, schema: schema.to_h, opts: opts }
          end
        end
      end
    end
  end
end
