require 'travis/conditions'
require 'travis/yml/helper/obj'

module Travis
  module Yml
    class Condition
      include Helper::Obj, Memoize

      attr_reader :cond, :data

      def initialize(cond, config, data)
        @cond = normalize(cond)
        @data = merge(data, config.dup)
      end

      def accept?
        return true unless cond
        Travis::Conditions.eval(cond, data, version: :v1)
      rescue TypeError, ArgumentError => e
        Raven.capture_exception(e, extra: { condition: cond, data: data }) if defined?(Raven)
        raise InvalidCondition, e.message
      rescue Travis::Conditions::Error, RegexpError => e
        raise InvalidCondition, e.message
      end

      def normalize(cond)
        cond.to_s unless cond.nil? || cond.is_a?(Array) || cond.is_a?(Hash)
      end

      def merge(data, config)
        config[:env] = config[:env][:global] if config[:env].is_a?(Hash) && config[:env].key?(:global)
        super
      end

      def to_s
        "IF #{config[:if]}"
      end
    end
  end
end
