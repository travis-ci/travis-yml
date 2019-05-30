module Travis
  module Yml
    module Schema
      module Export
        include Helper::Obj
        extend self

        # Walks the tree and extracts nodes to the root nodes's exports,
        # replacing them with references.

        def apply(node)
          # export_includes(node) if node.respond_to?(:includes)
          # export_types(node) if node.respond_to?(:types)
          # export_map(node) if node.respond_to?(:mappings)
          # # p node[:user] if node.is_a?(Def::Deploy::Puppetforge)
          export(node)
        end

        # def export_includes(node)
        #   includes = node.includes.map { |type| apply(type) }
        #   node.includes.replace(includes)
        # end
        #
        # def export_types(node)
        #   types = node.types.map { |type| apply(type) }
        #   node.types.replace(types)
        # end
        #
        # def export_map(node)
        #   map = node.mappings.map { |key, value| [key, apply(value)] }.to_h
        #   node.mappings.replace(map)
        # end

        def export(node)
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

        # def all?(node, type)
        #   return if node.id || !node.seq? # || node.normal?
        #   return if node.types.any? { |type| type.opts.any? }
        #   # return true if node.types.none?
        #   node.types.all? { |node| node.is?(type) || node.is?(:ref) && node.id == type }
        # end
      end
    end
  end
end
