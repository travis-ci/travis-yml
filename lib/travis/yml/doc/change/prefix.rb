# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/helper/match'

module Travis
  module Yml
    module Doc
      module Change
        class Prefix < Base
          def apply
            # puts
            # p value.serialize
            # p schema.type
            # p schema.prefix
            # p prefix?
            apply? && prefix? ? prefixed : value
          end

          def apply?
            schema.map? && schema.prefix?
          end

          def prefix?
            schema.prefix? && !known_keys?(value)
          end

          def known_keys?(value)
            case value.type
            when :map then keys(value).any? { |key| schema.known?(key) }
            when :seq then known_keys?(value.first)
            end
          end

          def prefixed
            other = build(schema.prefix => value)
            other
          end

          def keys(value)
            keys = schema.keys.map(&:to_s)
            keys = value.keys.map { |key| match(keys, key) || key }
            keys.map(&:to_sym)
          end

          def match(keys, key)
            Match.new(keys, key.to_s).run
          end
        end
      end
    end
  end
end
