module Synchronize
  module ClassMethods
    def synchronize(name)
      prepend Module.new {
        define_method(name) do |*args, &block|
          mutex.synchronize { super(*args, &block) }
        end
      }
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end
