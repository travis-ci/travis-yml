# frozen_string_literal: true
module Travis
  module Yaml
    module Helper
      module Common
        BOOLS = [TrueClass, FalseClass]

        def str?(value)
          value.is_a?(String) || value.is_a?(Regexp)
        end

        def bool?(value)
          BOOLS.include?(value.class)
        end

        def false?(value)
          value.is_a?(FalseClass)
        end

        def present?(value)
          case value
          when Array, Hash then !value.empty?
          when *BOOLS then true
          else !!value
          end
        end

        def blank?(value)
          !present?(value)
        end

        def to_array(obj)
          obj.is_a?(Array) ? obj : [obj].compact
        end

        def compact(obj)
          case obj
          when Hash  then obj.select { |_, obj| Common.present?(obj) }
          when Array then obj.select { |obj| Common.present?(obj) }
          else obj
          end
        end

        def swap(hash)
          hash.inject({}) do |hash, (key, values)|
            Array(values).inject(hash) do |hash, value|
              hash[value] ||= []
              hash[value] << key
              hash
            end
          end
        end

        def only(hash, *keys)
          hash.select { |key, _| keys.include?(key) }.to_h
        end

        def except(hash, *keys)
          hash.reject { |key, _| keys.include?(key) }.to_h
        end

        def strip(string)
          string.to_s.gsub(/(^[\u00A0\s]+|[\u00A0\s]+$)/, '')
        end

        def camelize(string)
          string.to_s.split('_').collect(&:capitalize).join
        end

        def underscore(str)
          str.to_s.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
            gsub(/([a-z\d])([A-Z])/,'\1_\2').
            tr('-', '_').
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
