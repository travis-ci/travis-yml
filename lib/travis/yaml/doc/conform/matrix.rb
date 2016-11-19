require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Matrix < Conform
          include Helper::Common

          register :matrix

          def apply?
            mapping.any? && !support.supported?
          end

          def apply
            support.msgs.each { |key, value| msg(key, value) }
            node.value = nil
          end

          private

            def msg(key, value)
              node.parent.msg :error, :unsupported, node.key, node.value, key, value
            end

            def support
              @support ||= Support.new(node, only(opts, :only, :except))
            end

            def opts
              # TODO hrmmmmm ...
              only(mapping[:types].first, :only, :except)
            end

            def mapping
              @opts ||= Yaml.spec[:map][node.key] || {}
            end
        end
      end
    end
  end
end
