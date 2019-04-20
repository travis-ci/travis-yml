
# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Type
        module Expand
          extend self

          def apply(node)
            Node.expand(node)
          end

          class Node
            include Helper::Obj, Registry

            def self.expand(node)
              registered?(node.type) ? self[node.type].new.apply(node) : node
            end

            def expand(node)
              self.class.expand(node)
            end

            # def build(type, opts = {})
            #   other = Type::Node[type].new(node.parent, node.id)
            #   opts.each { |key, obj| other.set(key, obj) }
            #   other
            # end
          end

          class Map < Node
            register :map

            def apply(node)
              node = expand_map(node)
              node = prefix(node) if node.prefix?
              node
            end

            def expand_map(node)
              map = node.map { |key, node| [key, expand(node)] }.to_h
              node.mappings.replace(map)
              node
            end

            def prefix(node)
              opts = node.opts
              opts = opts.merge(namespace: node.namespace)
              opts = opts.merge(id: node.id)
              opts = opts.merge(title: node.title)
              opts = opts.merge(support: node.support)
              opts = opts.merge(export: node.export?)
              opts = except(opts, :normal, :changes)

              schemas = [node, node[node.prefix]]
              opts = opts.merge(schemas: schemas)

              any = Type::Any.new(node.parent, opts)
              any.set :normal, nil
              any.schemas.each.with_index do |node, ix|
                node.set(:normal, ix == 0 ? true : nil)
                node.set(:export, false) if ix == 0
                node.parent = any
              end

              any
            end

            # def includes(schema)
            #   { allOf: [schema, *jsons(node.includes).map(&:schema)] }
            # end
            #
            # def prefix(schema)
            #   { anyOf: normals([schema, json(node[node.prefix]).schema]) }
            # end
          end

          class Seq < Node
            register :seq

            def apply(node)
              type = detect(node, :str, :secure)
              type ? ref("#{type}s", node) : wrap(node)
            end

            def wrap(node)
              # p [node.id, node.type, title: node.title, export: node.export?] if node.id == :archs

              opts = node.instance_variable_get(:@opts) || {}
              opts = merge(opts, *node.schemas.map(&:opts))
              opts = opts.merge(namespace: node.namespace)
              opts = opts.merge(id: node.id)
              opts = opts.merge(title: node.title)
              opts = opts.merge(support: node.support)
              opts = opts.merge(export: node.export?)
              opts = except(opts, :normal, :changes)

              schemas = [node, *node.map { |node| expand(node) }]
              schemas = flatten(schemas)
              opts = opts.merge(schemas: schemas)

              any = Type::Any.new(node.parent, opts)
              any.set :normal, nil
              any.each.with_index do |node, ix|
                node.set(:normal, ix == 0 ? true : nil)
                node.set(:export, false) if ix == 0
                node.parent = any
              end

              any
            end

            def flatten(schemas)
              schemas.map { |schema| schema.is?(Any) ? schema.schemas : schema }.flatten
            end

            def ref(type, node)
              opts = {
                id: node.id,
                title: node.title,
                namespace: node.namespace,
                ref: type,
                export: node.export? ,
                opts: merge(node.opts, *node.schemas.map(&:opts)),
              }
              Type::Ref.new(node.parent, opts)
            end

            def detect(node, *types)
              types.detect { |type| all?(node, type) }
            end

            def all?(node, type)
              node.all?(&:"#{type}?") && node.none?(&:enum?) && node.none?(&:vars?)
            end
          end
        end
      end
    end
  end
end
