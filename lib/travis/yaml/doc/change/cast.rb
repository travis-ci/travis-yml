require 'travis/yaml/doc/change/base'
require 'travis/yaml/doc/value/cast'
require 'travis/yaml/doc/value/secure'
require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Doc
      module Change
        class Cast < Base
          include Helper::Common

          def apply
            return node unless cast?
            casted = cast.apply
            msg(casted) if msg? && casted != value
            node.set(casted)
          end

          private

            def cast?
              node.scalar? && present?(value) && !secure? && cast.apply?
            end

            def secure?
              value.is_a?(Doc::Value::Secure)
            end

            def cast
              @cast ||= Doc::Value::Cast.new(value, spec.cast)
            end

            def msg(casted)
              node.info :cast, given_value: value, given_type: cast.given, value: casted, type: cast.type
            end

            def msg?
              !bool2str? && !num2str? # && !str2bool?
            end

            def bool2str?
              # e.g. `install: true`, as given in our docs
              [true, false].include?(value) && spec.cast == :str
            end

            def num2str?
              # e.g. `git: depth: 10`, as given in our docs (?)
              value.is_a?(Integer) && spec.cast == :str
            end

            # def str2bool?
            #   # e.g. `sudo: "false"`, as given in our docs (?)
            #   ['true', 'false'].include?(value) && spec.cast == :bool
            # end

            def value
              node.value
            end
        end
      end
    end
  end
end
