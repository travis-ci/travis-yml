module Travis
  module Yaml
    module Load
      def self.apply(parts)
        parts = [parts] unless parts.is_a?(Array)
        parts = parts.map { |part| Parse.new(part).apply }
        Merge.new(parts).apply
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

      class Merge < Struct.new(:parts)
        def apply
          parts.inject({}) do |lft, rgt|
            send(merge_mode(rgt), lft.to_h, rgt.to_h)
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
            rgt.merge(lft)
          end

          DEEP_MERGE = -> (key, lft, rgt) do
            rgt.is_a?(Hash) && lft.is_a?(Hash) ? rgt.merge(lft, &DEEP_MERGE) : lft || rgt
          end

          def deep_merge(hash, other)
            hash.merge(other, &DEEP_MERGE)
          end
      end
    end
  end
end
