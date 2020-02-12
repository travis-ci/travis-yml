module Travis
  module Yml
    module Instrument
      module ClassMethods
        def instrument(name)
          prepend Module.new {
            define_method(name) do |*args, &block|
              start = Time.now
              super(*args, &block).tap do
                self.class.instruments.each do |instrument|
                  instrument.call(name, args, start, Time.now)
                end
              end
            end
          }
        end

        def instruments
          @instruments ||= []
        end

        def subscribe(&block)
          instruments << block
        end
      end

      def self.included(const)
        const.extend(ClassMethods)
      end
    end
  end
end

