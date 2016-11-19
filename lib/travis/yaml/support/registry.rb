module Travis
  module Registry
    MSGS = {
      unknown: 'can not use unregistered object %p. known objects are: %p'
    }

    class Registry
      def each(&block)
        objects.each(&block)
      end

      def keys
        objects.keys
      end

      def []=(key, object)
        objects[key.to_sym] = object
      end

      def [](key)
        key && objects[key.to_sym] || fail(MSGS[:unknown] % [key.inspect, objects.keys.inspect])
      end

      def objects
        @objects ||= {}
      end

    end

    class << self
      def included(base)
        base.send(:extend, ClassMethods)
        base.send(:include, InstanceMethods)
        base.instance_variable_set(:@registry, Registry.new)
      end

      def [](key)
        registries[key] ||= Registry.new
      end

      def registries
        @registries ||= {}
      end
    end

    module ClassMethods
      attr_reader :registry_key

      def [](key)
        key && registry[key.to_sym] || fail(MSGS[:unknown] % [key.inspect, registry.keys.inspect])
      end

      def register(key, obj = self)
        registry[key] = obj
        obj.instance_variable_set(:@registry_key, key)
      end

      def registry
        @registry ||= respond_to?(:superclass) && superclass.respond_to?(:registry) ? superclass.registry : Registry.new
      end
    end

    module InstanceMethods
      def registry_key
        self.class.registry_key
      end
    end
  end
end
