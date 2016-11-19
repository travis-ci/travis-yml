require 'travis/yaml/doc/change/base'
require 'travis/yaml/doc/value/cast'
require 'travis/yaml/doc/value/secure'
require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Doc
      module Change
        class Downcase < Base
          def apply
            downcase? ? downcase : node
          end

          private

            def downcase?
              node.scalar? &&
              node.present? &&
              spec.downcase? &&
              value.respond_to?(:downcase) &&
              downcased != value
            end

            def downcase
              node.info :downcase, value: value
              node.set(downcased)
            end

            def downcased
              value.downcase
            end

            def value
              node.value
            end
        end
      end
    end
  end
end
