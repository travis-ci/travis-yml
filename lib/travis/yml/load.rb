require 'travis/yml/part'

module Travis
  module Yml
    module Load
      def self.apply(parts)
        parts = [parts] unless parts.is_a?(Array)
        parts = parts.map { |part| Parse.new(part).apply }
        Merge.new(parts).apply.to_h
      end

      class Parse
        attr_reader :part

        def initialize(part)
          @part = part
        end

        def apply
          hash = send(:"parse_#{format}")
          unexpected_format! unless hash.is_a?(Hash)
          config_for(hash)
        end

        private

          def format
            part.start_with?('{') ? :json : :yaml
          end

          def parse_json
            Oj.load(part.to_s)
          end

          def parse_yaml
            LessYAML.load(part.to_s, raise_on_unknown_tag: true) || {}
          end

          def config_for(hash)
            Config.new(hash).tap do |config|
              next unless part.respond_to?(:src)
              config.merge_mode = part.merge_mode
              config.src = part.src
            end
          end

          def unexpected_format!
            raise UnexpectedConfigFormat, 'Input must be a hash'
          end
      end

      # With the following config sources, sent/included in this order:
      #
      #   # from api payload
      #   script: ./api
      #   env:
      #     global:
      #       api: true
      #       foo: 1
      #
      #   # from .travis.yml, merge_mode: deep_merge
      #   script: ./travis_yml
      #   env:
      #     global:
      #       travis_yml: true
      #       foo: 2
      #
      #   # from imported.yml, merge_mode: deep_merge
      #   script: ./imported
      #   env:
      #     global:
      #       imported: true
      #       foo: 3
      #
      #
      # We expect the result:
      #
      #   script: ./api
      #   env:
      #     global:
      #       imported: true
      #       foo: 1
      #       travis_yml: true
      #       api: true
      #
      # This is because:
      #
      # * The order of the list represents the order of precedence, what's
      #   listed first wins.
      # * "Winning" in terms of ENV vars means being listed later, and/or
      #   having the right value.
      # * The strange position of the key :foo is due to Ruby's behaviour of
      #   keeping the key in the same place, but overwriting the value.

      class Merge < Struct.new(:parts)
        DEEP_MERGE = -> (key, lft, rgt) do
          lft.is_a?(Hash) && lft.is_a?(Hash) ? lft.merge(rgt, &DEEP_MERGE) : rgt
        end

        def apply
          parts.inject do |lft, rgt|
            send(merge_mode(rgt), rgt.to_h, lft.to_h)
          end
        end

        private

          def merge_mode(part)
            part.respond_to?(:merge_mode) ? part.merge_mode : :merge
          end

          def replace(lft, rgt)
            rgt
          end

          def merge(lft, rgt)
            lft.merge(rgt)
          end

          def deep_merge(lft, rgt)
            lft.merge(rgt, &DEEP_MERGE)
          end
      end
    end
  end
end
