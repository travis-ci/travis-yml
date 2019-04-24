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
              prefix required strict support unique)
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
                silent?(key) || !strict? && formatted?(key)
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

          def keys
            map.keys
          end

          def key?(key)
            map.key?(key)
          end

          def values
            map.values
          end

          def alias?(key)
            aliases.key?(key)
          end

          def aliases
            compact(opts[:keys].map do |key, opts|
              opts.fetch(:aliases, []).map { |name| [name, key] }
            end.flatten(1).to_h)
          end
          memoize :aliases

          def format
            opts[:format]
          end

          def formatted?(key)
            !format || Regexp.new(format).match?(key.to_s)
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
            opts[:keys]&.fetch(key, {})&.fetch(:deprecated, nil)
          end

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
            opts[:unique] || []
          end

          def max_size?
            !!opts[:max_size]
          end

          def max_size
            opts[:max_size]
          end

          def known?(key)
            known.include?(key&.to_sym)
          end

          def known
            keys + aliases.keys
          end
          memoize :known

          def misplaced?(key)
            misplaced.include?(key&.to_sym)
          end

          def misplaced
            Yml.keys - known
          end
          memoize :misplaced

          def expand_keys
            opts[:expand]
          end

          def all_keys
            map.keys
          end

          def support(key)
            only(opts[:keys][key] || {}, :only, :except)
          end

          def to_h
            compact(id: id, key: key, type: type, value: map.map { |key, obj| [key, obj.to_h] }.to_h, opts: opts)
          end

          def all_keys
            keys = map.map { |key, node| [key, node.all_keys] }
            keys + aliases.values
            keys.flatten.compact.uniq.sort
          end
        end
      end
    end
  end
end
