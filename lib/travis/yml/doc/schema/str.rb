# frozen_string_literal: true
require 'travis/yml/doc/schema/scalar'

module Travis
  module Yml
    module Doc
      module Schema
        class Str < Scalar
          def self.opts
            @opts ||= super + %i(downcase format vars)
          end

          def matches?(value)
            super and !format || formatted?(value.value)
          end

          def type
            :str
          end

          def downcase?
            !!opts[:downcase]
          end

          def format?
            !!opts[:format]
          end

          def format
            opts[:format]
          end

          def formatted?(str)
            Regexp.new(format).match?(str.to_s)
          end

          def vars?
            vars.any?
          end

          def var?(var)
            vars.include?(var)
          end

          def vars
            opts[:vars] ||= []
          end
        end
      end
    end
  end
end
