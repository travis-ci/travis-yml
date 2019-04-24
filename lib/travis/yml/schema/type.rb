require 'travis/yml/schema/type/all'
require 'travis/yml/schema/type/any'
require 'travis/yml/schema/type/bool'
require 'travis/yml/schema/type/enum'
require 'travis/yml/schema/type/forms'
require 'travis/yml/schema/type/lang'
require 'travis/yml/schema/type/map'
require 'travis/yml/schema/type/node'
require 'travis/yml/schema/type/num'
require 'travis/yml/schema/type/one'
require 'travis/yml/schema/type/opts'
require 'travis/yml/schema/type/ref'
require 'travis/yml/schema/type/schema'
require 'travis/yml/schema/type/secure'
require 'travis/yml/schema/type/seq'
require 'travis/yml/schema/type/str'

module Travis
  module Yml
    module Schema
      module Type
        extend self

        # Expands Any and Seq nodes to Seq nodes or other types, e.g.
        #
        #   any(seq(map, str), bool) => [seq(map), seq(str), bool]
        #   any(map, str)            => [map, str]
        #   map                      => [map]
        #
        def expand(node)
          case node.type
          when :any
            node.types.map { |node| expand(node) }.flatten
          when :seq
            nodes = node.types.map { |node| expand(node) }.flatten
            nodes.map { |node| Seq.new(node.parent, types: [node]) }
          else
            [node]
          end
        end

        def exported(namespace, id)
          exports[namespace]&.fetch(id, nil)
        end

        def export(obj)
          exports[obj.namespace] ||= {}
          exports[obj.namespace][obj.id] = obj
        end

        def exports
          @exports ||= {}
        end

        def resolve(type)
          type.is_a?(Class) ? type : Node[type]
        end

        def transform(node)
          Type::Forms.apply(node)
        end
      end
    end
  end
end
