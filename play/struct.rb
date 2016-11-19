require 'benchmark'

class A < Struct.new(:foo)
end

class B
  attr_reader :foo

  def initialize(foo)
    @foo = foo
  end
end

n = 100_000_000

Benchmark.bmbm do |x|
  x.report('struct')     { a = A.new('foo'); n.times { a.foo } }
  x.report('initialize') { a = B.new('foo'); n.times { a.foo } }
end
