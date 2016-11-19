require 'travis/yaml/doc/conform/conform'
require 'travis/yaml/doc/helper/support'

module Travis
  module Yaml
    module Doc
      module Conform
        class Incompatible < Conform
          register :incompatible

          def apply?
            !support.supported?
          end

          def apply
            support.msgs.each do |msg|
              node.error :unsupported, node.key, node.value, *msg
            end
          end

          private

            def support
              @support ||= Support.new(node, value ? value.opts : {})
            end

            def value
              @values ||= node.values.detect { |value| value == node.value }
            end
        end
      end
    end
  end
end
