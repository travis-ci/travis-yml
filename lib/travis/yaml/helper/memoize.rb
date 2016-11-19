module Travis
  module Yaml
    module Helper
      module Memoize
        module ClassMethods
          def memoize(name)
            prepend Module.new {
              define_method(name) do |*args|
                raise 'cannot pass arguments to memoized method %p' % name unless args.empty?
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
    end
  end
end
