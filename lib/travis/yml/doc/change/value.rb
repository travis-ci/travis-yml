# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/helper/match'

module Travis
  module Yml
    module Doc
      module Change
        class Value < Base
          include Memoize

          def apply
            apply? ? change : value
          end

          private

            def change
              value = self.value
              value = dealias(value) if unknown?(value) && alias?(value)
              value = fix(value)     if unknown?(value)
              value
            end

            def apply?
              schema.enum? && value.str?
            end

            def fix(value)
              value = split(value) if split?(value)
              value = find(value)  if unknown?(value)
              value = clean(value) if unknown?(value) && clean?(value)
              value
            end

            def split?(value)
              value.value.include?("\n")
            end

            def split(value)
              other = value.value.split("\n").first
              value.warn :clean_value, original: value.value, value: other
              value.set(other)
            end

            def find(value)
              return value unless other = Match.new(values, value.value, schema.stop).run
              value.warn :find_value, original: value.value, value: other
              value.set(other)
            end

            def clean?(value)
              value.value && cleaned(value)
            end

            def clean(value)
              other = cleaned(value)
              value.warn :clean_value, original: value.value, value: other
              value.set(other)
            end

            def cleaned(value)
              str  = value.value.gsub(/\W/, '').downcase
              part = value.value.split(' ').first.to_s
              detect(part, str, part.gsub(/[^a-z]/, ''))
            end

            def dealias(value)
              value.info :alias, alias: value.value, value: aliased(value)
              value.set(aliased(value))
            end

            def alias?(value)
              schema.values.alias?(value.value)
            end

            def aliased(value)
              schema.values.aliased(value.value)
            end

            def unknown?(value)
              !values.include?(value.value)
            end

            def values
              schema.values.map(&:to_s)
            end

            def detect(*strs)
              strs.detect { |str| values.include?(str) }
            end
        end
      end
    end
  end
end

