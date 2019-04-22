# frozen_string_literal: true
require 'travis/yml/doc/schema/str'
require 'travis/yml/doc/schema/values'

module Travis
  module Yml
    module Doc
      module Schema
        class Enum < Str
          def self.opts
            @opts ||= super + %i(enum values strict)
          end

          def matches?(value)
            super and known?(value.value) || values.alias?(value.value) || !strict?
          end

          def type
            :enum
          end

          def is?(type)
            super || type == :str
          end

          def size
            values.size
          end

          def known?(str)
            values.any? { |value| value.to_s == str }
          end

          def alias?(str)
            str && aliases.key?(str.to_sym)
          end

          def strict?
            !!opts[:strict]
          end

          def each(&block)
            values.each(&block)
          end

          def any?(&block)
            block ? values.any?(&block) : super
          end

          def values
            Values.new(opts[:values].map { |value| Value.new(value) })
          end
          memoize :values
        end
      end
    end
  end
end
