# frozen_string_literal: true
require 'travis/yml/doc/change/base'

module Travis
  module Yml
    module Doc
      module Change
        class Pick < Base
          def apply
            other = pick? ? pick : value
            other
          end

          def pick?
            !schema.matches?(value) && value.seq? && value.given? && matches?
          end

          def matches?
            case schema.type
            when :seq
              !schema.matches?(value) && schema.matches?(value.first)
            else
              schema.matches?(change(value.first)) || schema.scalar? && value.first.scalar?
            end
          end

          def change(value)
            Change.apply(schema, value)
          end

          def pick
            value.warn :unexpected_seq, value: value.first.serialize
            value.first
          end
        end
      end
    end
  end
end
