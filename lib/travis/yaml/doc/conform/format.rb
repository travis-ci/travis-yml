require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Format < Conform
          register :format

          def apply?
            node.format && !applies?
          end

          def apply
            node.error :invalid_format, node.value
          end

          private

            def applies?
              node.value =~ node.format
            end
        end
      end
    end
  end
end
