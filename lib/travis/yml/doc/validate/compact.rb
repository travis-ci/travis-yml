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
            schema.seq? && value.seq? || schema.map? && value.map?
          end

          def compact?
            values.any?(&:missing?)
          end

          def compact
            build(send(:"compact_#{value.type}"))
          end

          def compact_seq
            value.reject { |value| warn(value) if value.missing? }
          end

          def compact_map
            value.reject { |_, value| warn(value) if value.missing? }.to_h
          end

          def values
            value.seq? ? value : value.values
          end

          def warn(value)
            value.msg :warn, :empty if warn?(value)
            true
          end

          def warn?(value)
            !value.none? && !value.errored?
          end
        end
      end
    end
  end
end
