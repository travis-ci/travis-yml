# frozen_string_literal: true
require 'travis/yml/doc/schema/node'
require 'travis/yml/doc/schema/values'

module Travis
  module Yml
    module Doc
      module Schema
        class Scalar < Node
          def self.opts
            @opts ||= super + %i(defaults values strict)
          end

          def scalar?
            true
          end

          def enum?
            values.any?
          end

          # def matches?(value)
          #   super and !enum? || known?(value.value) || values.alias?(value.value)
          # end

          def default?
            defaults.any?
          end

          def defaults
            Values.new(Array(opts[:defaults]).map { |value| Value.new(value) })
          end
          memoize :defaults

          def size
            values.size
          end

          def known?(value)
            values.any? { |v| v == value } # .to_s
          end

          def values
            Values.new(Array(opts[:values]).map { |value| Value.new(value) })
          end
          memoize :values
        end
      end
    end
  end
end
