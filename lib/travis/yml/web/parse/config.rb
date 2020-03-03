# frozen_string_literal: true
require 'oj'
require 'travis/yml'

module Travis
  module Yml
    module Web
      class Parse
        class Config
          LEVELS = %i(alert error warn info unknown)

          attr_reader :config, :msgs

          def initialize(config)
            @config = config.serialize
            @msgs = sort(config.msgs)
          end

          def to_h
            {
              version: 'v1',
              messages: messages,
              full_messages: full_messages,
              config: config
            }
          end

          private

          def messages
            msgs.map do |level, key, code, args|
              compact(
                type: 'config',
                level: level,
                key: key,
                code: code,
                args: unkey(except(args, :src, :line)),
                src: args[:src],
                line: args[:line]
              )
            end
          end

          def full_messages
            msgs.map do |msg|
              Travis::Yml.msg(msg)
            end
          end

          def sort(msgs)
            msgs.sort_by do |msg|
              LEVELS.index(msg.first || :unknown) || LEVELS[:unknown]
            end
          end

          def unkey(args)
            args.map { |key, value| [key, value.is_a?(::Key) ? value.to_s : value] }.to_h
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
  end
end
