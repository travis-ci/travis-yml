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
            return node if !apply? || parses?
            parse_error
          end

          private

            def apply?
              node.key == :if && node.value
            end

            def parses?
              Travis::Conditions.parse(node.value, keys: KEYWORDS)
              true
            rescue Travis::Conditions::ParseError
              false
            end

            def parse_error
              node.error :invalid_cond, value: node.value
            end
        end
      end
    end
  end
end
