module Travis
  module Yaml
    module Doc
      module Normalize
        class Prefix < Normalizer
          register :prefix

          def apply
            self.value = { prefix => value } if prefix?
            value
          end

          private

            def prefix?
              prefix && !(prefixed? || mapped?) && (!type || matches?)
            end

            def prefixed?
              value.is_a?(Hash) && value.keys.include?(prefix)
            end

            def mapped?
              value.is_a?(Hash) && value.keys.&(keys).any?
            end

            def prefix
              spec.fetch(:prefix, {})[:key]
            end

            def keys
              spec[:map] ? spec[:map].keys : []
            end

            def type
              spec.fetch(:prefix, {})[:type]
            end

            def matches?
              type == case value
              when Hash  then :map
              when Array then :seq
              else :scalar
              end
            end
        end
      end
    end
  end
end
