require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Downcase < Conform
          register :downcase

          def apply?
            node.present? && node.downcase? && downcase?
          end

          def apply
            node.info :downcase, node.value
            node.value = node.value.downcase
          end

          private

            def downcase?
              node.value.respond_to?(:downcase) && node.value.downcase != node.value
            end
        end
      end
    end
  end
end
