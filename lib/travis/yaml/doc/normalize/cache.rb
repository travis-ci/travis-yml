require 'travis/yaml/doc/normalize/normalizer'

module Travis
  module Yaml
    module Doc
      module Normalize
        class Cache < Normalizer
          register :cache

          def apply
            normalize(value)
          end

          private

            def normalize(value)
              case value
              when true, false then on_bool(value)
              when String      then on_string(value)
              when Array       then on_array(value)
              when Hash        then value
              else value
              end
            end

            def on_bool(value)
              spec[:types].map { |type| [type, value] }.to_h
            end

            def on_string(value)
              { value.to_sym => true }
            end

            def on_array(value)
              value = self.value.map { |value| normalize(value) }
              value.inject(&:merge)
            end
        end
      end
    end
  end
end
