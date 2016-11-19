require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Doc
      module Factory
        class Seq < Struct.new(:spec, :value, :node)
          include Helper::Common

          def add_children
            add_values if value
            add_opts
          end

          def add_values
            to_a(value).each do |value|
              type = detect_type(value)
              type = type.merge(only(spec, *Node::INHERIT))
              type = type.merge(given: true)
              node.children << Node.new(type, node, node.key, value).build
            end
          end

          def add_opts
            # in case we need to add a default child later
            node.opts = node.opts.merge(types: spec[:types])
          end

          def detect_type(value)
            Types.new(spec[:types], value).detect
          end
        end
      end
    end
  end
end
