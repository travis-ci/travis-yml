require 'travis/yml/schema/type/all'
require 'travis/yml/schema/type/any'
require 'travis/yml/schema/type/bool'
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

        # Expands Any and Seq nodes to Seq nodes or other types (used by
        # Schema::Docs). E.g.:
        #
        #   any(seq(map, str), bool) => [seq(map), seq(str), bool]
        #   any(map, str)            => [map, str]
        #   map                      => [map]
        #
        def expand(node)
          case node
          when Any
            node.types.map { |node| expand(node) }.flatten
          when Seq
            nodes = node.types.map { |node| expand(node) }.flatten.compact
            nodes.map { |node| Seq.new(node.parent, types: [node]) }
          when Ref
            expand(node.lookup)
          else
            [node]
          end
        end
      end
    end
  end
end
