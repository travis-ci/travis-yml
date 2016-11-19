require 'travis/yaml/doc/spec/scalar'

module Travis
  module Yaml
    module Doc
      module Spec
        class Fixed < Scalar
          register :fixed

          def type
            :fixed
          end

          def is?(type)
            super || type == :scalar
          end

          def values
            Array(spec[:values]).map { |value| Value.new(value) }
          end
          memoize :values
        end
      end
    end
  end
end
