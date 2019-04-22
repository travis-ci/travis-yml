# frozen_string_literal: true
require 'travis/yml/doc/schema/node'
require 'travis/yml/doc/schema/values'

module Travis
  module Yml
    module Doc
      module Schema
        class Scalar < Node
          def self.opts
            @opts ||= super + %i(defaults)
          end

          def scalar?
            true
          end

          def default?
            defaults.any?
          end

          def defaults
            Values.new(Array(opts[:defaults]).map { |value| Value.new(value) })
          end
          memoize :defaults
        end
      end
    end
  end
end
