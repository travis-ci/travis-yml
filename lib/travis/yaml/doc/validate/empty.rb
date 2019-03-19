# frozen_string_literal: true
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class Empty < Validator
          register :empty

          def apply
            empty? ? empty : node
          end

          def empty?
            !node.root? && node.blank?
          end

          def empty
            node.parent.msg :warn, :empty, key: node.key if warn?
            node.drop
          end

          def warn?
            !spec.scalar? && !node.errored?
          end
        end
      end
    end
  end
end
