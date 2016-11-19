require 'travis/yaml/doc/value/node'

module Travis
  module Yaml
    module Doc
      module Value
        class Secure < Node
          class << self
            def secure?(value)
              value.is_a?(Hash) && value.keys.any? { |key| secure_key?(key) }
            end

            def secure_key(*keys)
              key = keys.detect { |key| key.to_s.gsub(/\W/, '') == 'secure' }
              key.to_sym if key
            end

            def secure_key?(key)
              !!secure_key(key)
            end
          end

          attr_accessor :value

          def initialize(parent, key, value, opts)
            super(parent, key, nil, opts)
            @value = value[self.class.secure_key(*value.keys)]
          end

          def type
            :secure
          end

          def present?
            !!value
          end

          def raw
            { secure: value }
          end

          def serialize
            value ? raw : nil
          end

          def merge(*)
            throw :unmergeable
          end

          def to_s
            "{ secure: #{obfuscated.inspect} }"
          end
          alias inspect to_s

          def secure?
            true
          end

          def drop
            self.value = nil
            self
          end

          private

            def obfuscated
              value ? '*' * value.to_s.size : nil
            end
        end
      end
    end
  end
end
