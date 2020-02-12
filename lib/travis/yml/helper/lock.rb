module Travis
  module Yml
    class Lock
      attr_reader :mutex, :var

      def initialize
        @mutex = Mutex.new
        @var = ConditionVariable.new
      end

      def wait
        mutex.synchronize do
          var.wait(mutex)
        end
      end

      def release
        var.signal
      end
    end
  end
end
