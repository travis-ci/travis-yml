# frozen_string_literal: true
require 'travis/yaml/doc/helper/support'
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class UnsupportedKey < Validator
          include Helper::Support

          register :unsupported_key

          def apply
            unsupported? ? unsupported : node
          end

          private

            def unsupported?
              node.present? && !relevant?
            end

            def unsupported
              support.msgs.inject(node) do |node, msg|
                node.error :unsupported, msg.merge(key: node.key, value: node.raw)
              end
            end
        end
      end
    end
  end
end
