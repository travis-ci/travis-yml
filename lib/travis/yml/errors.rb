# frozen_string_literal: true
module Travis
  module Yml
    class Error < StandardError
      attr_reader :data

      def initialize(msg, data = {})
        @data = data
        msg = "#{msg} (source: #{data[:source]})" if data[:source]
        super(msg)
      end
    end

    # Errors relating to implementation
    class InternalError < Error; def internal?; true end; end
    class MemoizedArgs < InternalError; end
    class StackTooHigh < InternalError; end
    class UnknownMessage < InternalError; end

    # Errors relating to user input
    class InputError < Error; def internal?; false end; end
    class SyntaxError < InputError; end
    class InvalidConfigFormat < InputError; end
    class UnexpectedParentType < InputError; end
    class UnexpectedValue < InputError; end
    class InvalidCondition < InputError; end
  end
end
