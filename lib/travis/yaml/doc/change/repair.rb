require 'travis/yaml/doc/change/base'
require 'travis/yaml/doc/helper/keys'

module Travis
  module Yaml
    module Doc
      module Change
        class Repair < Base
          include Helper::Keys

          def apply
            repair? ? repair : node
          end

          private

            def repair?
              parent &&
              parent.seq? &&    # parent's parent is a seq??
              node.map? &&      # node is a map
              spec.scalar? &&   # spec wants a scalar
              single_value? &&  # hash contains a single value that is a string or nil
              spec.strict? &&   # not an open map
              special_chars?    # key contains special chars
            end

            def repair
              # YAML removes extra whitespace before the colon, but we know
              # there must have been whitespace after the colon.
              repaired = [key, value].to_a.flatten.join(': ').strip
              parent.warn :repair, key: key, value: value, to: repaired
              changed parent.replace(node, build(parent, node.key, repaired, node.opts))
            end

            def parent
              node.parent
            end

            def single_value?
              return false unless node.size == 1
              value.is_a?(String) || value.nil?
            end

            def special_chars?
              !key.to_s.scan(/[^\w\-\.]/).empty?
            end

            def key
              @key ||= node.keys.first.to_s
            end

            def value
              @value ||= node.values.first.raw
            end
        end
      end
    end
  end
end
