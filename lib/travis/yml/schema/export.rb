module Travis
  module Yml
    module Schema
      module Export
        include Helper::Obj
        extend self

        # Walks the tree and extracts nodes to the root nodes's exports,
        # replacing them with references.

        def apply(node)
          export_includes(node) if node.respond_to?(:includes)
          export_types(node) if node.respond_to?(:types)
          export_map(node) if node.respond_to?(:mappings)
          export(node)
        end

        def export_includes(node)
          includes = node.includes.map { |type| apply(type) }
          node.includes.replace(includes)
        end

        def export_types(node)
          types = node.types.map { |type| apply(type) }
          node.types.replace(types)
        end

        def export_map(node)
          map = node.mappings.map { |key, value| [key, apply(value)] }.to_h
          node.mappings.replace(map)
        end

        def export(node)
          if other = defined(node)
            add(other)
            ref(other, node.opts)
          elsif node.export?
            add(node)
            # hmmm. we'd want to pass options that have been passed to the
            # mapping, but this information is not available anymore.
            ref(node, only(node.opts, :aliases, :deprecated, :only, :except, :strict))
          else
            node
          end
        end

        def ref(node, opts = {})
          opts = opts.merge(namespace: node.namespace, id: node.id)
          Type::Ref.new(node.parent, opts)
        end

        def add(node)
          exports = node.root.exports
          exports << node unless exports.include?(node)
        end

        def defined(node)
          type = %i(str secure).detect { |type| all?(node, type) }
          Type::Node["#{type}s"].new(node.parent) if type
        end

        def all?(node, type)
          return unless !node.id && node.seq? && !node.normal?
          return if node.any? { |node| node.opts.any? }
          node.none? || node.all? { |node| node.send(:"#{type}?") || node.ref? && node.id == type }
        end
      end
    end
  end
end
