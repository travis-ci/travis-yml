# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Unique < Base
          include Memoize

          register :duplicate

          def apply
            warn if apply? && dupes?
            value
          end

          private

            def apply?
              schema.seq? && schema.schema.map? && schema.schema.unique?
            end

            def dupes?
              value.given? && dupes.any?
            end

            def dupes
              unique.map { |key| dupes_on(key) }.inject(&:merge)
            end
            memoize :dupes

            def dupes_on(key)
              values = values_on(key)
              dupes = values.select { |value| values.count(value) > 1 }
              compact(key.to_sym => dupes.uniq)
            end

            def values_on(key)
              items.select(&:map?).map { |map| map[key]&.value }.compact
            end

            def unique
              schema.schema.unique
            end

            def items
              value.value
            end

            def warn
              value.info :duplicate, dupes
            end

            def compact(obj)
              obj.reject { |_, obj| obj.nil? || obj.empty? }
            end
        end
      end
    end
  end
end
