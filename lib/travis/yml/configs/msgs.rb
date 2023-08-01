require 'travis/yml/helper/obj'
require 'pry'
module Travis
  module Yml
    class Msgs

      include Enumerable, Helper::Obj
      attr_reader :msgs

      def initialize
        @msgs = []
      end

      def each(&block)
        to_a.each(&block)
      end

      def to_a
        msgs.uniq
      end

      def concat(other)
        msgs.concat(other.to_a)
      end

      def messages
        to_a.map do |level, key, code, args|
          message(level, key, code, args || {})
        end
      end

      def message(level, key, code, args)
        {
          type: 'config',
          level: level,
          key: key,
          code: code,
          args: except(args, :src, :line),
          src: args[:src],
          line: args[:line]
        }.reject { |_, obj| obj.nil? || obj.respond_to?(:empty?) && obj.empty? }
      end

      def full_messages
        to_a.map do |msg|
          Yml.msg(msg)
        end
      end
    end
  end
end
