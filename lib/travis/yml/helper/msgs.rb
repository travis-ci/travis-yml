require 'travis/yml/helper/obj'

module Travis
  module Yml
    class Msgs

      include Enumerable, Helper::Obj
      attr_reader :msgs

      def initialize
        @msgs = []
      end

      def each(&block)
        msgs.each(&block)
      end

      def to_a
        msgs
      end

      def concat(other)
        msgs.concat(other.to_a)
      end

      def messages
        msgs.map do |level, key, code, args|
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
        msgs.map do |msg|
          Yml.msg(msg)
        end
      end
    end
  end
end
