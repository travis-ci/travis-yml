# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate 
        class UniqueValueGlobally < Base
          register :unique_value_globally

          def apply
            error if apply? && dupes?
            value
          end

          private

            def apply?
              schema.map? && schema.unique_value_globally? && value.given?
            end

            def dupes?
              return false if top_obj == nil
              top_obj.unique_value_globally_already_used ||= []
              return true if top_obj.unique_value_globally_already_used.include?(value.first.last.value)
              top_obj.unique_value_globally_already_used << value.first.last.value
              false
            end

            def top_obj
              top = nil
              top = value.parent if value.parent !=nil && value.parent.class.method_defined?(:unique_value_globally_already_used)
              if top != nil
                while top.parent != nil && top.parent.class.method_defined?(:unique_value_globally_already_used)
                  top = top.parent
                end
              end
              top
            end

            def error
              value.error :duplicate, values: top_obj.unique_value_globally_already_used
            end
        end
      end
    end
  end
end
