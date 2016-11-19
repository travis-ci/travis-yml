require 'travis/yaml/doc/normalize/normalizer'

module Travis
  module Yaml
    module Doc
      module Normalize
        class Enabled < Normalizer
          register :enabled

          def apply
            normalize(value)
          end

          private

            def normalize(value)
              case value
              when true, false then on_bool(value)
              when Hash        then on_hash(value)
              else value
              end
            end

            def on_bool(value)
              { enabled: value }
            end

            def on_hash(hash)
              value = hash[:enabled] if hash.key?(:enabled)
              value = !hash.delete(:disabled) if hash.key?(:disabled)
              value = except(hash, :enabled).any? if value.nil?
              hash.merge(enabled: value)
            end
        end
      end
    end
  end
end
