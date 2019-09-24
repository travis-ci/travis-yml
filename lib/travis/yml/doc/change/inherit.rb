# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/helper/match'

module Travis
  module Yml
    module Doc
      module Change
        class Inherit < Base
          def apply
            apply? && inherit? ? inherit : value
          end

          private

            def apply?
              schema.map? && value.map?
            end

            def inherit?
              schema.change?(:inherit)
            end

            def inherit
              other = value.map do |key, value|
                value = change(schema[key], value) unless value.map? || value.seq?
                next [key, value] unless value.map? || value.seq?
                value = case value.type
                when :seq then inherit_seq(value)
                when :map then inherit_map(value)
                end
                [key, value]
              end
              build(except(other.to_h, *keys))
            end

            def inherit_seq(value)
              other = value.value.map do |value|
                value.map? ? inherit_map(value) : value
              end
              build(other)
            end

            def inherit_map(value)
              values = only(self.value, *keys - value.keys)
              values = values.map { |key, value| [key, value] }.to_h
              value.value.merge(values)
            end

            def change(schema, value)
              schema ? Change.apply(schema, value) : value
            end

            def keys
              schema.change(:inherit)[:keys].map(&:to_s)
            end
        end
      end
    end
  end
end
