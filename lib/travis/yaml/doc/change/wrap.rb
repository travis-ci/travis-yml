# frozen_string_literal: true
require 'travis/yaml/doc/change/base'

module Travis
  module Yaml
    module Doc
      module Change
        class Wrap < Base
          def apply
            wrap? ? wrap : node
          end

          def wrap?
            node.parent && spec.seq? && !node.seq?
          end

          def wrap
            # node.debug :wrap, key: node.key, node_type: node.type, spec_type: spec.type
            value = node.present? ? [node] : []
            build(node.parent, node.key, value, node.opts)
          end
        end
      end
    end
  end
end
