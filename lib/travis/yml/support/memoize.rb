# frozen_string_literal: true
module Travis
  module Memoize
    class ArgsError < StandardError; end

    module ClassMethods
      def memoize(name)
        prepend Module.new {
          define_method(name) do |*args|
            raise ArgsError.new('cannot pass arguments to memoized method %p' % name) unless args.empty?
            result = super()
            singleton_class.send(:define_method, name) { result } # TODO this isn't really thread safe, is it?
            result
          end
        }
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
