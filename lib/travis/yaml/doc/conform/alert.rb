require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Alert < Conform
          register :alert

          def apply?
            node.alert? && node.secure? && string?
          end

          def apply
            node.error :alert
          end

          private

            def string?
              node.value.is_a?(String)
            end
        end
      end
    end
  end
end
