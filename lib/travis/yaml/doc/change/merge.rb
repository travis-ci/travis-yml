require 'travis/yaml/doc/change/base'

module Travis
  module Yaml
    module Doc
      module Change
        class Merge < Base
          def apply
            merge? ? merge : node
          end

          private

            def merge?
              spec.map? && node.seq? && maps? && !prefix?
            end

            def merge
              return node unless other = merged
              node.warn :invalid_seq, value: other.raw
              other = node.parent.set(node.key, other)
              changed other
            end

            def merged
              catch :unmergeable do
                other = node.merge
              end
            end

            def maps?
              node.present? && node.all?(&:map?)
            end

            def prefix?
              Prefix.new(spec, node, opts).prefix?
            end
        end
      end
    end
  end
end
