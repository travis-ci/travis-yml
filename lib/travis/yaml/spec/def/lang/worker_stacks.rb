require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      WORKER_STACKS = [:connie, :amethyst, :garnet, :stevonnie, :opal, :sardonyx, :onion, :cookiecat]

      WORKER_STACKS.each do |stack|
        klass = Def.const_set(stack.capitalize, Class.new(Type::Lang))
        klass.register :"__#{stack}__"
        klass.class_eval do
          define_method(:define) do
            name :"__#{stack}__", deprecated: true
          end
        end
      end
    end
  end
end
