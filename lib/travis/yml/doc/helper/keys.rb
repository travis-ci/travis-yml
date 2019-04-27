# frozen_string_literal: true
require 'travis/yml/doc/helper/match'

module Travis
  module Yml
    module Doc
      module Keys
        def self.dict
          path  = File.expand_path('../../../var/keys.dict', __FILE__)
          lines = File.read(path).split("\n")
          parts = lines.map { |line| split(line) }
          parts = parts.map { |key, value| [key.to_sym, value] }
          parts.to_h
        end

        def self.split(str)
          key, _, value = str.rpartition(' ');
          [key, value]
        end

        DICT = dict

        def lookup_key(key)
          key = DICT[key] unless schema.stop?(key)
          key.to_sym if key
        end

        def match_key(keys, key)
          key = Match.new(keys.map(&:to_s), key.to_s, schema.stop).run
          key.to_sym if key
        end

        def clean_keys(keys)
          keys.map { |key| clean_key(key) }
        end

        def clean_key(key)
          key = key.to_s
          key = key.tr('- ', '_')
          key = key.gsub(/(\W)/, '')
          key = key.gsub(/(^_+|_+$)/, '')
          key = key.gsub('__', '_')
          key = key.to_sym
        end

        extend self
      end
    end
  end
end
