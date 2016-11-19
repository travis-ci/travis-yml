require 'travis/yaml/doc/helper/support'
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class Default < Validator
          include Helper::Support

          register :default

          def apply
            return node unless default?
            node.info :default, key: node.key, default: default if msg?
            default_node
          end

          private

            def default?
              node.blank? && relevant? && spec.default? && !(node.map? && node.parent.seq?)
            end

            def invalid_type?
              node.errored? && node.type != spec.type
            end

            def default_node
              value = spec.seq? ? [default] : default
              Value.build(node.parent, node.key, value, node.opts)
            end

            def default
              supported[:value]
            end

            def supported
              @supported ||= spec.defaults.detect do |default|
                Value::Support.new(node.supporting, default).supported?
              end
            end

            def msg?
              ![:sudo, :os, :dist].include?(node.key) # TODO
            end
        end
      end
    end
  end
end
