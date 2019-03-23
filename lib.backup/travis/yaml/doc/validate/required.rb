# frozen_string_literal: true
require 'travis/yaml/doc/helper/support'
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class Required < Validator
          include Helper::Support

          register :required

          def apply
            required? ? required : node
          end

          private

            def required?
              node.blank? && relevant? && spec.required?
            end

            def required
              node.parent.error :required, key: node.key
              node
            end
        end
      end
    end
  end
end
