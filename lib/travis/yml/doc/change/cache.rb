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
              respond_to?(:"apply_#{value.type}", true)
            end

            def caches
              send(:"apply_#{value.type}")
            end

            def apply_str
              str = schema.match(bool_keys, value.value) || value.value
              value.info(:find_value, original: value.value, value: str) unless value.value == str
              build(str(str))
            end

            def apply_seq
              build(merge(*seq(value.serialize(false)).flatten))
            end

            def seq(seq)
              seq.map do |value|
                case value
                when Array
                  seq(value)
                when Hash
                  map(value)
                else
                  str(value)
                end
              end
            end

            def map(map)
              map.map do |key, value|
                if bool?(key)
                  { key => true }
                elsif key == 'directories'
                  { key => value }
                else
                  { key => value }
                end
              end
            end

            def str(str)
              bool?(str) ? { str => true } : { 'directories' => [str] }
            end

            def bool?(str)
              bool_keys.include?(str)
            end

            def bool_keys
              schema.keys.select { |key| schema[key].bool? } - ['edge']
            end
            memoize :bool_keys
          end
      end
    end
  end
end
