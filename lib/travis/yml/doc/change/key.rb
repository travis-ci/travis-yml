# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/helper/dict'

module Travis
  module Yml
    module Doc
      module Change
        class Key < Base
          include Doc::Dict

          FILTERS = %i(strip underscore clean lookup find)

          def apply
            key = value.key
            raise key.inspect if key.is_a?(Symbol)
            key = dealias(key) if !known?(key) && alias?(key)
            key = fix(key)     if !known?(key)
            key
          end

          def fix(key)
            FILTERS.each do |name|
              key = send(name, key)
              key = dealias(key) if !known?(key) && alias?(key)
              return key if known?(key)
            end
            key
          end

          def strip(key)
            other = super(key)
            return key if !known?(other)
            info :strip_key, key, other if key != other
            other
          end

          def underscore(key)
            other = strict? ? super(key) : key.to_s.tr('-', '_')
            return key unless known?(other)
            info :underscore_key, key, other if key != other
            other
          end

          def clean(key)
            other = clean_key(key)
            return key unless known?(other)
            info :clean_key, key, other if key != other
            other
          end

          def lookup(key)
            return key unless strict? && Dict.key?(key)
            other = Dict[key] unless schema.stop?(key, Dict[key])
            return key unless key == other || known?(other)
            warn :find_key, key, other if key != other
            other
          end

          def find(key)
            return key unless strict?
            other = match_key(key.to_s)
            return key unless known?(other) || alias?(other)
            warn :find_key, key, other if key != other
            other
          end

          def dealias(key)
            other = schema.aliases[key]
            return key if !other || key == other
            value.parent.info :alias, alias: key, key: other
            other
          end

          def strict?
            schema.strict?
          end

          def known?(key)
            schema.key?(key)
          end

          def alias?(key)
            schema.alias?(key)
          end

          def info(type, key, other)
            msg :info, type, key, other
          end

          def warn(type, key, other)
            msg :warn, type, key, other
          end

          def msg(level, type, key, other)
            value.parent.msg level, type, original: key, key: other
          end

          def match_key(key)
            schema.match(schema.known - Yml.r_keys, key.to_s)
          end

          def clean_key(key)
            key = key.to_s
            key = key.tr('- ', '_')
            key = key.gsub(/(\W)/, '')
            key = key.gsub(/(^_+|_+$)/, '')
            key = key.gsub('__', '_')
            key
          end
        end
      end
    end
  end
end
