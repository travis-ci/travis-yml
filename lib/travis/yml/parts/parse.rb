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
            when Hash  then obj.map { |key, obj| [key(key), assign(obj)] }.to_h
            when Array then obj.map { |obj| assign(obj) }
            else obj
            end
          end

          def key(key)
            return key unless key.is_a?(String)
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
            LessYAML.load(part.str, raise_on_unknown_tag: true) || {}
          end

          def unexpected_format!
            raise UnexpectedConfigFormat, 'Input must be a hash'
          end
      end
    end
  end
end
