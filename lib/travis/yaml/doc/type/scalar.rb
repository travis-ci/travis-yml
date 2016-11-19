require 'travis/yaml/doc/type/node'

module Travis
  module Yaml
    module Doc
      module Type
        class Scalar < Node
          register :scalar

          def types
            Array(opts[:cast] || :str)
          end

          def secure?
            types == [:secure]
          end

          def downcase?
            !!opts[:downcase]
          end

          def error(*)
            super
            drop
          end

          def drop
            self.value = nil
          end
        end
      end
    end
  end
end
