# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/helper/dict'

module Travis
  module Yml
    module Doc
      module Change
        class Key < Base
          include Doc::Dict

          FILTERS = %i(strip underscore clean find)

          def apply
            key = value.key
            key = dealias(key) if !known?(key) && alias?(key)
            key = fix(key)     if !known?(key) && fix?
            key
          end

          def dealias(key)
            other = schema.key_aliases[key] || schema.key_aliases[key.to_s.tr('-', '_')]
            return key if !other || key == other
            value.parent.info :alias, type: :key, alias: key, obj: other, line: key.line, src: key.src
            other
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
            warn :strip_key, key, other if key != other
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
            warn :clean_key, key, other if key != other
            other
          end

          def find(key)
            lookup(key) || match(key) || key
          end

          def lookup(key)
            return unless strict? && Dict.key?(key)
            other = Dict[key] unless schema.stop?(key, Dict[key])
            return unless known?(other)
            warn :find_key, key, other if key != other
            key.copy(other)
          end

          def match(key)
            return unless strict?
            other = match_key(key.to_s)
            return unless known?(other) || alias?(other)
            warn :find_key, key, other if key != other
            key.copy(other)
          end

          def fix?
            value.fix?
          end

          def strict?
            schema.strict?
          end

          def known?(key)
            schema.key?(key)
          end

          def alias?(key)
            schema.key_alias?(key) || schema.key_alias?(key.to_s.tr('-', '_'))
          end

          def info(type, key, other)
            msg :info, type, key, other
          end

          def warn(type, key, other)
            msg :warn, type, key, other
          end

          def msg(level, type, key, other)
            value.parent.msg level, type, original: key, key: other, line: key.line, src: key.src
          end

          def match_key(key)
            schema.match(schema.known - Yml.r_keys, key.to_s)
          end

          def clean_key(key)
            key = key.to_s
            key = key.tr('- ', '_')
            key = key.gsub(/[^\w\.\_]/, '')
            key = key.gsub(/(^__+|_+$)/, '')
            key = key.gsub('__', '_')
            key
          end
        end
      end
    end
  end
end
