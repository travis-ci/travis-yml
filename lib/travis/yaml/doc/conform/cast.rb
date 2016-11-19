require 'travis/yaml/doc/conform/conform'
require 'travis/yaml/doc/helper/cast'

module Travis
  module Yaml
    module Doc
      module Conform
        class Cast < Conform
          register :cast

          def apply?
            node.present? && typed? && !secure? && cast.apply?
          rescue Doc::Cast::Error => e
            true
          end

          def apply
            casted = cast.apply
            warn(value, casted, cast.type::KEY) if warn?
            node.value = casted
          rescue Doc::Cast::Error => e
            node.error :invalid_type, value.class.name, value
          end

          private

            def typed?
              node.types.any?
            end

            def secure?
              node.types.include?(:secure) && [String, Doc::Secure].include?(value.class)
            end

            def warn?
              !bool2str? && !str2bool?
            end

            def warn(*args)
              node.warn :cast, *args
            end

            def bool2str?
              # TODO e.g. `install: true`, as given in our docs, should not warn. so, change the docs?
              [true, false].include?(value) && cast.type::KEY == :str
            end

            def str2bool?
              # TODO e.g. `sudo: "false"`, as given in our docs (?), should not warn. so, change the docs?
              ['true', 'false'].include?(value) && cast.type::KEY == :bool
            end

            def cast
              @cast ||= Doc::Cast.new(value, types)
            end

            def value
              node.value
            end

            def types
              node.types
            end
        end
      end
    end
  end
end
