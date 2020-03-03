module Spec
  module Support
    module Hash
      def only(hash, *keys)
        hash.select { |key, _| keys.include?(key) }.to_h
      end

      def except(hash, *keys)
        hash.reject { |key, _| keys.include?(key) }.to_h
      end

      def symbolize(obj)
        case obj
        when ::Hash then obj.map { |key, obj| [key.to_sym, symbolize(obj)] }.to_h
        when Array  then obj.map { |obj| symbolize(obj) }
        else obj
        end
      end

      def stringify(hash)
        JSON.load(JSON.dump(hash))
      end
    end
  end
end
