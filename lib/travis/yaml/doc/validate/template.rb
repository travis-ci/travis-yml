# frozen_string_literal: true
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class Template < Validator
          register :template

          def apply
            unknown? ? unknown : node
          end

          private

            def unknown?
              !unknown_vars.empty?
            end

            def unknown
              unknown_vars.inject(node) do |node, var|
                node.error :unknown_var, var: var
              end
            end

            def unknown_vars
              @unknown_vars ||= vars.select { |var| !known.include?(var) }
            end

            def known
              @known ||= Array(opts[:vars])
            end

            def vars
              node.value.to_s.scan(/%{([^}]+)}/).to_a.flatten
            end
        end
      end
    end
  end
end
