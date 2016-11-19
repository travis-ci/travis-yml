module Travis
  module Yaml
    module Spec
      module Type
        class Lookup < Struct.new(:opts)
          Node.register :lookup, self

          class << self
            def [](*keys)
              Class.new(self) { @keys = keys }
            end

            def keys
              @keys
            end
          end

          def spec
            { type: :lookup, keys: self.class.keys }
          end
        end
      end
    end
  end
end
