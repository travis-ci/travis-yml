# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/helper/match'

module Travis
  module Yml
    module Doc
      module Change
        class Cache < Base
          def apply
            apply? ? caches : value
          end

          private

            def apply?
              schema.change?(:cache) && caches?
            end

            def caches?
              respond_to?(:"from_#{value.type}", true)
            end

            def caches
              send(:"from_#{value.type}")
            end

            def from_bool
              value.warn(:deprecated, deprecation: :cache_enable_all, value: value.value)
              build(bool_keys.map { |key| { key => value.value } }.inject(&:merge))
            end

            def from_num
              value
            end

            def from_str
              str = schema.match(bool_keys.map(&:to_s), value.value) || value.value
              value.info(:find_value, original: value.value, value: str) unless value.value == str
              return value unless bool_keys.map(&:to_s).include?(str)
              build(str.to_sym => true)
            end

            def from_seq
              other = bools.inject(&:merge) || {}
              other = other.merge(dirs)
              other = other.merge(others)
              build(other)
            end

            def dirs
              dirs = maps.map { |value| value[:directories] if value.key?(:directories) }
              dirs = dirs.compact.flatten
              dirs = dirs + strs
              dirs.any? ? { directories: dirs } : {}
            end

            def bools
              bools = value.value.map do |value|
                case value.type
                when :str
                  key = value.value.to_sym
                  { key => true } if schema[key]&.bool?
                when :map
                  keys = value.keys.all? { |key| schema[key]&.bool? }
                  only(value.serialize, *keys)
                end
              end
              bools = bools.compact
              bools.any? ? bools.reject(&:empty?) : []
            end
            memoize :bools

            def maps
              value.select(&:map?).map(&:serialize)
            end

            def strs
              value.select(&:str?).map(&:serialize) - bool_keys.map(&:to_s)
            end

            def others
              others = maps.map { |value| except(value, :directories) }.inject(&:merge) || {}
            end

            def dir?(value)
              value.map? && value.key?(:directories)
            end

            def bool_keys
              schema.keys.select { |key| schema[key].bool? } - [:edge]
            end
            memoize :bool_keys
        end
      end
    end
  end
end
