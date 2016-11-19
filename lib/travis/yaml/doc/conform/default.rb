require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Default < Conform
          register :default

          def apply?
            !node.present? && node.relevant? && node.default?
          end

          def apply
            node.info :default, node.key, default if msg?
            node.is_a?(Type::Seq) ? default_entry : default_value
          end

          private

            def default_value
              node.value = default
            end

            def default_entry
              Factory::Seq.new(node.opts, default, node).add_children
            end

            def msg?
              ![:sudo, :os, :dist].include?(node.key) # TODO
            end

            def default
              node.default[:value]
            end
        end
      end
    end
  end
end
