require 'travis/yaml/doc/type/secure'

module Travis
  module Yaml
    module Doc
      class Cast < Struct.new(:value, :types)
        Error = Class.new(ArgumentError)

        class Caster < Struct.new(:value)
          def self.accept?(value)
            self::TYPES.include?(value.class)
          end
        end

        class Bool < Caster
          KEY = :bool

          def self.accept?(value)
            true
          end

          def apply
            case value
            when NilClass   then false
            when TrueClass  then value
            when FalseClass then value
            when Fixnum     then value != 0
            when Float      then value != 0.0
            when String     then value == 'false' ? false : true
            else true
            end
          end
        end

        class Str < Caster
          KEY   = :str
          TYPES = [NilClass, TrueClass, FalseClass, Fixnum, Float, String, Symbol]

          def apply
            value.to_s
          end
        end

        class Regex < Caster
          KEY   = :regex
          TYPES = [Regexp, String]

          def apply
            case value
            when Regexp
              value
            when String
              Regexp.new(value.gsub(%r((^/|/$)), ''))
            else
              raise Error
            end
          end
        end

        class Sec < Caster
          KEY   = :secure
          TYPES = [String, Secure]

          def apply
            value
          end
        end

        TYPES = {
          TrueClass   => Bool,
          FalseClass  => Bool,
          String      => Str,
          Symbol      => Str,
          Regexp      => Regex,
          Secure      => Sec,
        }

        def apply?
          !types.include?(key_for(value)) && !(secure? && str?)
        end

        def apply
          raise Error if secure?
          type.new(value).apply
        end

        def type
          type = consts.detect { |type| type.accept?(value) }
          type || raise(Error)
        end

        def default_type
          types.first
        end

        private

          def secure?
            value.is_a?(Secure)
          end

          def str?
            types.include?(:str)
          end

          def key_for(value)
            return :secure if secure?
            const = TYPES[value.class] || raise(Error)
            const::KEY
          end

          def consts
            self.types.map { |type| const_for(type) }.compact
          end

          def const_for(key)
            TYPES.values.detect { |type| type::KEY == key }
          end

          def to_bool
            case value
            when 'true'  then true
            when 'false' then false
            else !!value
            end
          end
      end
    end
  end
end
