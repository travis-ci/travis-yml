require 'travis/yml/support/yaml'

module Travis
  module Yml
    module Parts
      class Parse
        attr_reader :part

        def initialize(part)
          @part = part
        end

        def apply
          obj = parse
          invalid_format unless obj.is_a?(Hash)
          obj = assign(obj)
          obj
        end

        private

          def assign(obj)
            case obj
            when Hash
              obj.replace(obj.map { |key, obj| [src(key), assign(obj)] }.to_h)
            when Array
              obj.replace(obj.map { |obj| assign(obj) })
            else
              obj
            end
          end

          def src(key)
            key = Key.new(key) unless key.is_a?(Key)
            new_key = key.dup
            new_key.src = part.src
            new_key
          end

          def parse
            Yaml.load(part.str) || Map.new
          rescue Psych::SyntaxError => e
            raise ParseError, e.message
          end

          def invalid_format
            raise InvalidConfigFormat, 'Input must parse into a hash'
          end
      end
    end
  end
end
