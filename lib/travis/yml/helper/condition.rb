require 'travis/conditions'
require 'travis/yml/helper/obj'

module Travis
  module Yml
    class Condition < Struct.new(:config, :data)
      include Helper::Obj, Memoize

      def initialize(data, config)
        super(symbolize(data || {}), symbolize(config || {}))
      end

      def accept?
        return true unless cond
        Travis::Conditions.eval(cond, data, version: :v1)
      rescue Travis::Conditions::Error, ArgumentError, RegexpError, TypeError => e
        raise InvalidCondition, e.message
      end

      def cond
        return unless config.is_a?(Hash) && config.key?(:if) && !config[:if].nil?
        cond = config[:if]
        cond = cond.to_s unless cond.is_a?(Array) || cond.is_a?(Hash)
        cond
      end
      memoize :cond

      def to_s
        "IF #{config[:if]}"
      end
    end
  end
end
