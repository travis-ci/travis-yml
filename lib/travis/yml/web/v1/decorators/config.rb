# frozen_string_literal: true
require 'travis/yml'

module Travis::Yml::Web::V1
  module Decorators
    class Config
      LEVELS = %i(alert error warn info unknown)

      def initialize(config)
        @config = config
      end

      def call
        result = @config.serialize
        {
          version: 'v1',
          messages: messages,
          full_messages: full_messages,
          config: result
        }
      end

      private

      def messages
        sort(@config.msgs).map do |level, key, code, args|
          compact(
            type: 'config',
            level: level,
            key: key,
            code: code,
            args: except(args, :src, :line),
            src: args[:src],
            line: args[:line]
          )
        end
      end

      def full_messages
        sort(@config.msgs).map { |m| Travis::Yml.msg(m) }
      end

      def sort(msgs)
        msgs.sort_by { |msg| LEVELS.index(msg.first || :unknown) || LEVELS[:unknown] }
      end

      def compact(hash, *keys)
        hash.reject { |_, value| value.nil? }.to_h
      end

      def except(hash, *keys)
        hash.reject { |key, _| keys.include?(key) }.to_h
      end
    end
  end
end
