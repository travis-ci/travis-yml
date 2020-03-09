# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Required < Base
          register :required

          def apply
            apply? && missing? ? required : value
          end

          private

            def apply?
              enabled? && schema.map? && value.map?
            end

            def missing?
              missing.any?
            end

            def required
              missing.each { |key| value.error :required, key: key }
              drop? ? blank : value
            end

            def missing
              schema.required.select { |key| !value[key] || value[key].missing? }
            end
            memoize :missing

            def unsupported_defaults?(key)
              return false unless schema[key].respond_to?(:defaults)
              defaults = schema[key].defaults
              defaults.any? && defaults.none? { |default| supported?(default) }
            end

            def supported?(default)
              Value::Support.new(default.support, value.supporting, default.value).supported?
            end

            def enabled?
              value.defaults?
            end

            def drop?
              value.drop?
            end
        end
      end
    end
  end
end
