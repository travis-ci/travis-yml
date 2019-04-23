# frozen_string_literal: true
# require 'travis/yml/doc/helper/support'
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
              # relevant?
              enabled? && schema.map? && value.map?
            end

            def missing?
              missing.any?
            end

            def required
              missing.each { |key| value.error :required, key: key }
              blank
            end

            def missing
              keys.select { |key| !value[key] || value[key].missing? }
            end
            memoize :missing

            def keys
              schema.required
            end

            def enabled?
              value.enabled?(:defaults)
            end
        end
      end
    end
  end
end
