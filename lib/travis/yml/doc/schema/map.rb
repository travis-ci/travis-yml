# frozen_string_literal: true
require 'travis/yml/doc/schema/node'

module Travis
  module Yml
    module Doc
      module Schema
        class Map < Node
          register :map

          def self.opts
            @opts ||= super + %i(aliases format detect expand keys max_size
              prefix required strict unique) # support
          end

          attr_writer :map
          attr_accessor :schema

          def matches?(value)
            value.none? || matches_map?(value)
          end

          def matches_map?(value)
            value.map? && value.all? do |key, value|
              if key?(key)
                map[key].matches?(value)
              else
                custom?(key) || !strict? && formatted?(key)
              end
            end
          end

          def map
            @map ||= {}
          end

          def type
            :map
          end

          def [](key)
            map[key]
          end

          def key?(key)
            map.key?(key)
          end

          def keys
            map.keys
          end

          def values
            map.values
          end

          def key_alias?(key)
            key_aliases.key?(key)
          end

          def key_aliases
            aliases = map.map { |key, node| [key, node.aliases] }.to_h
            # if map.key?('on')
            #   p map['on'].schemas[0].aliases
            #   p map['on'].schemas[1].opts
            #   p map['on'].schemas[1].schemas[0].aliases
            #   p map['on'].schemas[1].schemas[1].aliases
            #   p map['on'].schemas[1].schemas[2].aliases
            #   p invert(compact(aliases))
            # end
            invert(compact(aliases))
          end
          memoize :key_aliases

          def format
            opts[:format]
          end

          def formatted?(key)
            !format || Regexp.new(format).match?(key.to_s)
          end

          def custom?(key)
            key.start_with?('_') || key.start_with?('.')
          end

          def default?(key = nil)
            defaults.include?(key)
          end

          def defaults
            map.select { |_, node| node.default? }.keys
          end
          memoize :defaults

          def deprecated_key?(key)
            !!deprecated_key(key)
          end

          def deprecated_key(key)
            deprecated_keys[key]
          end

          def deprecated_keys
            map.map { |key, node| [key, node.deprecated] }.to_h
          end
          memoize :deprecated_keys

          def required?(key = nil)
            key ? required.include?(key) : !!opts[:required]
          end

          def required
            opts[:required] || []
          end

          def unique?
            unique.any?
          end

          def unique
            map { |key, schema| key if schema.unique? }.compact.keys
          end
          memoize :unique

          def max_size?
            !!opts[:max_size]
          end

          def max_size
            opts[:max_size]
          end

          def known?(key)
            known.include?(key)
          end

          def known
            map.keys + key_aliases.keys # - Yml.r_keys
          end
          memoize :known

          def expand_keys
            opts[:expand]
          end

          def support(key)
            supports[key] || {}
          end

          def supports
            compact(map.map { |key, schema| [key, schema.supports] }.to_h)
          end
          memoize :supports

          def to_h
            compact(id: id, key: key, type: type, value: map.map { |key, obj| [key, obj.to_h] }.to_h, opts: opts)
          end

          def all_keys
            keys = map.map { |key, node| [key, node.all_keys] }
            keys + key_aliases.values
            keys.flatten.compact.uniq.sort
          end
        end
      end
    end
  end
end
