require 'benchmark'

module Memoize
  module SingletonClass
    module ClassMethods
      def memoize(name)
        prepend Module.new {
          define_method(name) do |*args|
            result = super()
            singleton_class.send(:define_method, name) { result }
            result
          end
        }
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end

  module InstanceVariable
    module ClassMethods
      def memoize(name)
        prepend Module.new {
          ivar = :"@#{name.to_s.gsub('!', 'bang').gsub('?', 'predicate')}"

          define_method(name) do |*args|
            return instance_variable_get(ivar) if defined?(ivar)
            instance_variable_set(ivar, super())
          end
        }
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end

  module Hash
    module ClassMethods
      def memoize(name)
        prepend Module.new {
          ivar = :"@#{name.to_s.gsub('!', 'bang').gsub('?', 'predicate')}"

          define_method(name) do |*args|
            @memoized ||= {}
            return @memoized[name] if @memoized.key?(name)
            @memoized[name] = super()
          end
        }
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end

class A
  def foo?
    strs = ['bar'] * 1000 << 'foo'
    strs.include?('foo')
  end
end

class B < A
  include Memoize::SingletonClass
  memoize :foo?
end

class C < A
  include Memoize::InstanceVariable
  memoize :foo?
end

class D < A
  include Memoize::Hash
  memoize :foo?
end

m = 1000
n = 1000

Benchmark.bmbm do |x|
  # x.report('unmemoized')        { m.times { a = A.new; n.times { a.foo? } } }
  x.report('singleton_class')   { m.times { b = B.new; n.times { b.foo? } } }
  x.report('instance_variable') { m.times { c = C.new; n.times { c.foo? } } }
  x.report('hash')              { m.times { d = D.new; n.times { d.foo? } } }
end
