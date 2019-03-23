# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Template < Base
          register :template

          def apply
            apply? && unknown? ? warn : value
          end

          private

            def apply?
              schema.str? && schema.vars?
            end

            def unknown?
              unknown.any?
            end

            def warn
              unknown.each do |var|
                value.warn :unknown_var, var: var
              end
              value
            end

            def unknown
              @unknown ||= given.reject { |var| schema.var?(var) }
            end

            def given
              value.value.to_s.scan(/%{([^}]+)}/).to_a.flatten
            end
        end
      end
    end
  end
end
