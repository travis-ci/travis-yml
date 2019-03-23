# frozen_string_literal: true
module Travis
  module Yml
    module Helper
      module Obj
        Nil = NilClass
        True = TrueClass
        False = FalseClass

        BOOLS = [TrueClass, FalseClass]

        # Boolean = Class.new

        def is?(obj, *types)
          types.any? { |type| obj.is_a?(type) }
        end

        def str?(obj)
          obj.is_a?(String)
        end

        NUMERIC = /\A[\d\.]+\Z/

        def num?(value)
          value.to_s =~ NUMERIC
        end

        def bool?(obj)
          BOOLS.include?(obj.class)
        end

        def true?(obj)
          obj.is_a?(TrueClass)
        end

        def false?(obj)
          obj.is_a?(FalseClass)
        end

        def given?(value)
          present? || false?(value)
        end

        def present?(obj)
          obj.respond_to?(:empty?) ? !obj.empty? : !!obj
        end

        def blank?(obj)
          !present?(obj)
        end

        def empty?(obj)
          obj.respond_to?(:empty?) && obj.empty?
        end

        def to_array(obj)
          obj.is_a?(Array) ? obj : [obj].compact
        end

        def to_syms(obj, *types)
          types = [String] unless types.any?
          case obj
          when Hash
            obj.map { |key, obj| [key, to_syms(obj, *types)] }.to_h
          when Array
            obj.map { |obj| types.any? { |type| obj.is_a?(type) } ? obj.to_s.to_sym : obj }
          else
            obj.is_a?(String) || types.any? { |type| obj.is_a?(type) } ? to_syms([obj], *types) : obj
          end
        end

        def to_strs(obj, *types)
          types = [Symbol] unless types.any?
          case obj
          when Hash
            obj.map { |key, obj| [key, to_strs(obj, *types)] }.to_h
          when Array
            obj.map { |obj| types.any? { |type| obj.is_a?(type) } ? obj.to_s : obj }
          else
            obj.is_a?(String) || types.any? { |type| obj.is_a?(type) } ? to_strs([obj], *types) : obj
          end
        end

        def symbolize(obj)
          case obj
          when Hash  then obj.map { |key, obj| [key.to_sym, symbolize(obj)] }.to_h
          when Array then obj.map { |obj| symbolize(obj) }
          else obj
          end
        end

        def stringify(hash)
          hash.map { |key, value| [key.to_s, value] }.to_h
        end

        def compact(obj)
          case obj
          when Hash
            obj = obj.map { |key, obj| [key, compact(obj)] }.to_h
            obj.reject { |_, obj| obj.nil? || empty?(obj) }
          when Array
            obj = obj.map { |obj| compact(obj) }
            obj.compact.reject { |obj| empty?(obj) }
          else
            obj
          end
        end

        def only(hash, *keys)
          hash.select { |key, _| keys.include?(key) }.to_h
        end

        def except(hash, *keys)
          hash.reject { |key, _| keys.include?(key) }.to_h
        end

        MERGE = -> (_, lft, rgt) do
          if lft.is_a?(::Hash) && rgt.is_a?(::Hash)
            lft.merge(rgt, &MERGE)
          elsif lft.is_a?(::Array) && rgt.is_a?(::Array)
            lft.dup.concat(rgt).uniq
          else
            rgt
          end
        end

        def merge(*objs)
          objs.inject { |lft, rgt| lft.merge(rgt, &MERGE) } || {}
        end

        def strip(string)
          string.to_s.gsub(/(^[\u00A0\s]+|[\u00A0\s]+$)/, '')
        end

        def camelize(string)
          string.to_s.split('_').map(&:capitalize).join
        end

        def titleize(string)
          string.to_s.split('_').map(&:capitalize).join(' ')
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

        def ivars
          instance_variables
        end

        def ivar(key, obj = nil)
          obj.nil? ? instance_variable_get("@#{key}") : instance_variable_set("@#{key}", obj)
        end

        extend self
      end
    end
  end
end
