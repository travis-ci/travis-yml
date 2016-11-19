require 'travis/yaml/doc/conform/conform'
require 'travis/yaml/doc/helper/support'

module Travis
  module Yaml
    module Doc
      module Conform
        class Unsupported < Conform
          register :unsupported

          def apply?
            node.present? && !node.relevant?
          end

          def apply
            node.support.msgs.each do |msg|
              node.error :unsupported, node.key, node.value, *msg
            end
          end
        end
      end
    end
  end
end
