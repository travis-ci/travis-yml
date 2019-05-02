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
                value = change(schema[key], value) unless value.map?
                next [key, value] unless value.map?
                values = only(self.value, *keys - value.keys)
                values = values.map { |key, value| [key, value] }.to_h
                [key, value.value.merge(values)]
              end
              build(except(other.to_h, *keys))
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
