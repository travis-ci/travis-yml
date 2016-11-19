module Travis
  class Obj
    CODE = {
      arg_default:    '%s = %p',
      assign:         '@%s = %s',
      assign_default: '@%s = %s || %p'
    }

    class << self
      def args_default(pair)
        CODE[:arg_default] % pair
      end

      def assign(name)
        CODE[:assign] % [name, name]
      end

      def assign_default(pair)
        name, value = *pair
        CODE[:assign_default] % [name, name, value]
      end

      def new(*attrs, &block)
        defaults = attrs.last.is_a?(Hash) ? attrs.pop : {}

        if attrs.empty? && defaults.empty?
          error = ArgumentError.new('wrong number of arguments (0 for 1+)')
          error.set_backtrace(caller)
          raise error
        end

        Class.new do
          attr_reader *attrs
          attr_reader *defaults.keys

          args = attrs + defaults.map(&Obj.method(:args_default))
          init = attrs.map(&Obj.method(:assign))
          init = init + defaults.map(&Obj.method(:assign_default))

          class_eval %(
            def initialize(#{args.join(', ')})
              #{init.join("\n")}
            end
          )
        end
      end
    end
  end
end
