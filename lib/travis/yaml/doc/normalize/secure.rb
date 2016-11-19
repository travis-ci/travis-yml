require 'travis/yaml/doc/type/secure'

module Travis
  module Yaml
    module Doc
      module Normalize
        class Secure < Normalizer
          register :secure

          def apply
            secure(value)
          end

          private

            def secure(value)
              case value
              when Hash  then secure?(value) ? to_secure(value) : on_hash(value)
              when Array then on_array(value)
              else value
              end
            end

            def secure?(value)
              value.keys.include?(:secure)
            end

            def on_hash(value)
              value.map { |key, value| [key, secure(value)] }.to_h
            end

            def on_array(value)
              value.map { |value| secure(value) }
            end

            def to_secure(value)
              Doc::Secure.new(value)
            end
        end
      end
    end
  end
end
