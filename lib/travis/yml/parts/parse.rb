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
          obj = send(format)
          unexpected_format! unless obj.is_a?(Hash)
          obj = assign(obj)
          obj
        end

        private

          def assign(obj)
            case obj
            when Hash
              obj.replace(obj.map { |key, obj| [src(key), assign(obj)] }.to_h)
            when Array
              obj.map { |obj| assign(obj) }
            else
              obj
            end
          end

          def src(key)
            key = Key.new(key) unless key.is_a?(Key)
            key.src = part.src
            key
          end

          def format
            part.str.start_with?('{') ? :json : :yaml
          end

          def json
            Oj.load(part.str)
          end

          def yaml
            Yaml.load(part.str) || {}
          end

          def unexpected_format!
            raise UnexpectedConfigFormat, 'Input must be a hash'
          end
      end
    end
  end
end
