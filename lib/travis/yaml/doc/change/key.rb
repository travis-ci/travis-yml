require 'travis/yaml/doc/helper/keys'
require 'travis/yaml/doc/change/base'
require 'travis/yaml/helper/common'
require 'travis/yaml/helper/memoize'

module Travis
  module Yaml
    module Doc
      module Change
        class Key < Base
          include Helper::Common, Helper::Keys, Helper::Memoize

          def apply
            key = node.key
            return dealias(key) if known?(key) && alias?(key)
            key = fix(key)
            key
          end

          def fix(key)
            %i(strip underscore clean lookup find).each do |name|
              key = send(name, key)
              key = dealias(key) if alias?(key)
              key = key.to_sym
              return key if known?(key) || node.key != key && misplaced?(key)
            end
            key
          end

          def strip(key)
            other = super(key)
            return key unless known?(other) || misplaced?(other)
            warn :strip_key, key.to_sym, other.to_sym if key.to_s != other.to_s
            other
          end

          def underscore(key)
            other = strict? ? super(key).to_sym : key.to_s.tr('-', '_').to_sym
            return key unless known?(other) || misplaced?(other)
            warn :underscore_key, key.to_sym, other.to_sym if key.to_s != other.to_s
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
            other = find_key(allowed, key)
            return key unless known?(other) || misplaced?(other)
            warn :find_key, key.to_sym, other.to_sym if key != other
            other
          end

          def dealias(key)
            other = spec.aliased[key.to_sym]
            return key if !other || key == other
            node.parent.info :alias, alias: key, actual: other
            other
          end

          def strict?
            spec.strict?
          end

          def known?(key)
            spec.known_key?(key)
          end

          def alias?(key)
            spec.alias?(key)
          end

          def misplaced?(key)
            spec.misplaced_key?(key)
          end

          def allowed
            spec.known_keys - Yaml.r_keys # TODO reduce keys on R
          end
          memoize :allowed

          def warn(type, key, other)
            node.parent.warn type, original: key.to_sym, key: other.to_sym
          end
        end
      end
    end
  end
end
