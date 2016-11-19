require 'travis/yaml/doc/helper/keys'
require 'travis/yaml/doc/change/base'
require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Doc
      module Change
        class Cache < Base
          include Helper::Common, Helper::Keys

          def apply
            return node if node.map? || node.secure? || blank?
            value = normalize(node.raw)
            return node if value == node.raw
            other = build(node.parent, node.key, value, node.opts)
            changed node.parent.set(node.key, other)
          end

          private

            def blank?
              !node.present?
            end

            def normalize(value)
              case value
              when Array  then on_seq(value)
              when *BOOLS then on_bool(value)
              when String then on_string(value)
              when Hash   then value
              else value
              end
            end

            def on_seq(value)
              unknown = value.reject { |value| known?(value) }
              value = value - unknown
              value = value.map { |value| normalize(value) }
              value << prefix(unknown) unless unknown.empty?
              value.flatten.inject(&:merge)
            end

            def on_bool(value)
              known.map { |type| [type, value] }.to_h
            end

            def on_string(value)
              return on_key(value) if known?(value)
              clean = clean_key(value)
              return on_cleaned_key(value, clean) if known?(clean)
              { directories: to_array(value) }
            end

            def on_key(value)
              { value.to_sym => true }
            end

            def on_cleaned_key(value, cleaned)
              node.warn :clean_value, original: value, value: cleaned
              on_key(cleaned)
            end

            def prefix(value)
              hashes = value.select { |value| value.is_a?(Hash) }
              prefixed = value.select { |value| prefixed?(value) }
              value = value - hashes - prefixed
              value = compact(directories: value)
              [value, hashes, prefixed].flatten.inject(&:merge)
            end

            def prefixed?(value)
              value.is_a?(Hash) && value.key?(:directories)
            end

            def known?(value)
              if value.is_a?(Hash)
                value.keys.any? { |key| known?(key) }
              else
                known.include?(value.to_sym)
              end
            end

            def known
              opts[:types]
            end

            def value
              node.value
            end
        end
      end
    end
  end
end
