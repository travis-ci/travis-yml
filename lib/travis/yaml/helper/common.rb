module Travis
  module Yaml
    module Helper
      module Common
        def present?(value)
          case value
          when Array, Hash
            value.any?
          else
            !!value
          end
        end

        def blank?(value)
          !present?(value)
        end

        def to_a(obj)
          obj.is_a?(Array) ? obj : [obj].compact
        end

        def compact(hash)
          hash.reject { |_, value| value.nil? || value.respond_to?(:empty?) && value.empty? }
        end

        def only(hash, *keys)
          hash.select { |key, _| keys.include?(key) }.to_h
        end

        def except(hash, *keys)
          hash.reject { |key, _| keys.include?(key) }.to_h
        end

        def camelize(string)
          string.to_s.split('_').collect(&:capitalize).join
        end

        def underscore(str)
          str. gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
            gsub(/([a-z\d])([A-Z])/,'\1_\2').
            tr("-", "_").
            downcase
        end

        def const_key(const)
          const_name(const).to_sym
        end

        def const_name(const)
          underscore(const.to_s.split('::').last.to_s)
        end

        extend self
      end
    end
  end
end
