# frozen_string_literal: true
require 'travis/yml/doc/schema/scalar'

module Travis
  module Yml
    module Doc
      module Schema
        class Values < Obj.new(:values)
          extend Forwardable
          include Enumerable, Memoize

          def_delegators :values, :each, :size

          def alias?(str)
            !!aliases[str]
          end

          def aliased(str)
            aliases[str]
          end

          def aliases
            merge(*map(&:aliases))
          end
          memoize :aliases

          def deprecated?(str)
            !!value(str)&.deprecated?
          end

          def deprecation(str)
            value(str)&.deprecation
          end

          def support(str)
            value(str)&.support
          end

          def value(str)
            detect { |value| value == str }
          end
        end

        class Value < Obj.new(:opts)
          include Memoize

          def [](key)
            opts[key]
          end

          def edge?
            !!opts[:edge]
          end

          def deprecated?
            !!deprecation
          end

          def deprecation
            opts[:deprecated]
          end

          def aliases
            Array(opts[:aliases]).map { |name| [name, value] }.to_h
          end

          def support
            only(opts, :only, :except)
          end
          memoize :support

          def value
            opts[:value]
          end

          def to_sym
            value.to_sym rescue nil
          end

          def ==(other)
            value == other
          end
        end
      end
    end
  end
end
