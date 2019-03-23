# frozen_string_literal: true
require 'travis/conditions'
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class Condition < Validator
          register :condition

          KEYWORDS = %i(type fork repo head_repo branch head_branch tag
            sender env)

          def apply
            return node unless apply?
            validate!
            node
          end

          private

            def apply?
              node.key == :if && node.value
            end

            def validate!
              Travis::Conditions.parse(node.value, keys: KEYWORDS, version: version)
            rescue Travis::Conditions::ParseError
              raise InvalidCondition.new(node.value)
            end

            def version
              node.root[:conditions]&.value == 'v0' ? :v0 : :v1
            end
        end
      end
    end
  end
end
