# frozen_string_literal: true
require 'travis/yaml/doc/value/map'
require 'travis/yaml/doc/value/node'
require 'travis/yaml/doc/value/scalar'
require 'travis/yaml/doc/value/seq'
require 'travis/yaml/doc/value/secure'

module Travis
  module Yaml
    module Doc
      module Value
        extend self

        def build(parent, key, value, opts)
          case value = secure(parent, key, value, opts)
          when Value::Node then value
          when Hash   then Map.new(parent, key, to_values(key, value, opts), opts)
          when Array  then Seq.new(parent, key, to_values(key, value, opts), opts)
          when Secure then value
          else Scalar.new(parent, key, value, opts)
          end
        end

        private

          def secure(parent, key, value, opts)
            Secure.secure?(value) ? Secure.new(parent, key, value, opts) : value
          end

          def to_values(key, value, opts)
            case value
            when Hash
              value.map { |key, value| [key, build(nil, key, value, opts)] }.to_h
            when Array
              value.flatten.map { |value| build(nil, key, value, opts) }
            else
              raise UnexpectedValue, value.inspect
            end
          end
      end
    end
  end
end
