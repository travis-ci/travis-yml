module Travis
  module Yml
    module Schema
      module Type
        module Export
          include Helper::Obj
          extend self

          def apply(node)
            if node.export?
              store(node)
              ref(node)
            elsif other = defined(node)
              store(other)
              ref(other, node.attrs)
            elsif node.secure?
              store(node)
              ref(node, node.attrs)
            else
              node
            end
          end

          def ref(node, opts = {})
            opts = opts.merge(namespace: node.namespace, id: node.id)
            Type::Ref.new(node.parent, opts)
          end

          def store(node)
            Type::Node.exports[node.ref.to_sym] ||= node
          end

          def defined(node)
            type = %i(strs secures).detect { |type| send(:"#{type}?", node) }
            Type::Node[type].new(node.parent) if type
          end

          def strs?(node)
            return false unless node.any?
            return false if node.types.any?(&:export?) || node.types.size != 2
            return false if node.types.any? { |type| except(type.opts, :normal).any? }
            node.types.all? { |node| node.str? || node.seq? && node.types.all?(&:str?) }
          end

          def secures?(node)
            return false unless node.any?
            return false if node.types.any?(&:export?) || node.types.size != 2
            return false if node.types.any? { |type| except(type.opts, :normal).any? }
            node.types.all? { |node| node.secure? || node.seq? && node.types.all?(&:secure?) }
          end
        end
      end
    end
  end
end
