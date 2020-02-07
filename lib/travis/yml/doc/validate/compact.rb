# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Compact < Base
          register :compact

          def apply
            apply? && compact? ? compact : value
          end

          def apply?
            schema.seq? && value.seq? || schema.map? && schema.strict? && value.map?
          end

          def compact?
            values.any?(&:missing?) && !schema.change?(:env_vars)
          end

          def compact
            build(send(:"compact_#{value.type}"))
          end

          def compact_seq
            value.reject(&:missing?)
          end

          def compact_map
            value.reject { |_, value| value.missing? }.to_map
          end

          def values
            value.seq? ? value : value.values
          end
        end
      end
    end
  end
end
