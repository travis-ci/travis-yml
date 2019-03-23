# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/helper/keys'

module Travis
  module Yml
    module Doc
      module Change
        class Key < Base
          include Doc::Keys

          def apply
            key = value.key
            key = dealias(key) if !known?(key) && alias?(key)
            key = fix(key)     if !known?(key)
            key
          end

          def fix(key)
            %i(strip underscore clean lookup find).each do |name|
              key = send(name, key)
              key = dealias(key) if !known?(key) && alias?(key)
              key = key.to_sym
              return key if known?(key) || value.key != key && misplaced?(key)
            end
            key
          end

          def strip(key)
            other = super(key).to_sym
            return key if !known?(other) || misplaced?(other)
            warn :strip_key, key.to_sym, other.to_sym if key.to_s != other.to_s
            other
          end

          def underscore(key)
            other = strict? ? super(key).to_sym : key.to_s.tr('-', '_').to_sym
            return key unless known?(other) || misplaced?(other)
            info :underscore_key, key.to_sym, other.to_sym if key.to_s != other.to_s
            other
          end

          def clean(key)
            other = clean_key(key)
            return key unless known?(other) || misplaced?(other)
            warn :clean_key, key.to_sym, other.to_sym if key.to_s != other.to_s
            other
          end

          def lookup(key)
            return key unless strict?
            other = lookup_key(key)
            return key unless key == other || known?(other) || misplaced?(other)
            warn :find_key, key.to_sym, other.to_sym if key != other
            other
          end

          def find(key)
            return key unless strict?
            other = match_key(allowed, key)
            return key unless known?(other) || alias?(other) || misplaced?(other)
            warn :find_key, key.to_sym, other.to_sym if key != other
            other
          end

          def dealias(key)
            other = schema.aliases[key.to_sym]
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

          def misplaced?(key)
            schema.misplaced?(key)
          end

          def allowed
            schema.keys + schema.aliases.keys
          end
          memoize :allowed

          def info(type, key, other)
            msg :info, type, key, other
          end

          def warn(type, key, other)
            msg :warn, type, key, other
          end

          def msg(level, type, key, other)
            value.parent.msg level, type, original: key.to_sym, key: other.to_sym
          end
        end
      end
    end
  end
end
