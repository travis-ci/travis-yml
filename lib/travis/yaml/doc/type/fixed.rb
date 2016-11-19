require 'travis/yaml/doc/type/scalar'
require 'travis/yaml/doc/type/value'
require 'travis/yaml/helper/memoize'

module Travis
  module Yaml
    module Doc
      module Type
        class Fixed < Scalar
          register :fixed

          include Helper::Memoize

          def values
            Array(opts[:values]).map { |value| Value.new(value) }
          end

          def alias?
            !!self.alias
          end

          def alias
            value_obj && value_obj.to_s
          end
          memoize :alias

          private

            def value_obj
              values.detect { |value| value.alias_for?(self.value) }
            end
        end
      end
    end
  end
end
