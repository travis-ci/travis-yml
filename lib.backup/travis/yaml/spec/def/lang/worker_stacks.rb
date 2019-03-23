# frozen_string_literal: true
require 'travis/yaml/spec/def/stack'
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      Def::Stack::VALUES.each do |stack|
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
