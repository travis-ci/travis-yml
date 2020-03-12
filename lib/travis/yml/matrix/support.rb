module Travis
  module Yml
    class Matrix
      class Support < Obj.new(:job, :key, :value)
        SUPPORTING = %i(language os arch)

        def supported?
          supported_key? && supported_value?
        end

        def supported_key?
          support(key_support).supported?
        end

        private

          def supported_value?
            support = value_support
            support ? support(support).supported? : true
          end

          def key_support
            Yml.expand.support(key.to_s)
          end

          def value_support
            schema = Yml.expand[key.to_s]
            schema = schema.detect(&:scalar?) if schema&.is?(:any)
            schema.values.support(value) if schema && schema.values.respond_to?(:support)
          end

          def support(support)
            Yml::Doc::Value::Support.new(support, supporting, value)
          end

          def supporting
            stringify(only(job, *SUPPORTING))
          end
      end
    end
  end
end
