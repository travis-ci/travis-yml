# frozen_string_literal: true
require 'travis/yaml/helper/common'
require 'travis/yaml/doc/helper/match'

module Travis
  module Yaml
    module Helper
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

        STOP = %i(
          after_vendor
          branch
          branches
          erlang
          gcc
          golang
          html
          jvm
          nvm
          pip
          prose
          sdk
          slack
          start_script
          trusty
          vimscript
        )

        def find_key(keys, key)
          return if STOP.include?(key.to_sym)
          key = Match.new(keys.map(&:to_s), key.to_s).run
          key.to_sym if key
        end

        def lookup_key(key)
          return if STOP.include?(key.to_sym)
          key = Keys::DICT[key]
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
