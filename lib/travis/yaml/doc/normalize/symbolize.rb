require 'travis/yaml/doc/normalize/normalizer'

module Travis
  module Yaml
    module Doc
      module Normalize
        class Symbolize < Normalizer
          register :symbolize

          def apply
            symbolize(value)
          end

          private

            def symbolize(obj)
              case obj
              when Hash
                obj.map { |key, obj| [fix_key(key).to_sym, symbolize(obj)] }.to_h
              when Array
                obj.map { |obj| symbolize(obj) }
              else
                fix_value(obj)
              end
            end

            def fix_key(key)
              # this should only happen during validation: our request configs
              # already have these values stored. once we're done validating
              # we might remove this
              key.is_a?(TrueClass) ? :on : key
            end

            def fix_value(obj)
              # this should only happen during validation: our request configs
              # already have these types stored. once we're done validating
              # we might remove this
              case obj
              when Fixnum, Float
                obj.to_s
              else
                obj
              end
            end
        end
      end
    end
  end
end
