require 'travis/yml/schema/def/root'
require 'travis/yml/schema/dsl/all'
require 'travis/yml/schema/dsl/any'
require 'travis/yml/schema/dsl/bool'
require 'travis/yml/schema/dsl/enum'
require 'travis/yml/schema/dsl/lang'
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/num'
require 'travis/yml/schema/dsl/one'
require 'travis/yml/schema/dsl/ref'
require 'travis/yml/schema/dsl/seq'
require 'travis/yml/schema/dsl/scalar'
require 'travis/yml/schema/dsl/secure'
require 'travis/yml/schema/dsl/str'
require 'travis/yml/schema/examples/bool'
require 'travis/yml/schema/examples/enum'
require 'travis/yml/schema/examples/group'
require 'travis/yml/schema/examples/map'
require 'travis/yml/schema/examples/num'
require 'travis/yml/schema/examples/ref'
require 'travis/yml/schema/examples/secure'
require 'travis/yml/schema/examples/seq'
require 'travis/yml/schema/examples/str'
require 'travis/yml/schema/json/enum'
require 'travis/yml/schema/json/group'
require 'travis/yml/schema/json/map'
require 'travis/yml/schema/json/ref'
require 'travis/yml/schema/json/seq'
require 'travis/yml/schema/json/scalar'
require 'travis/yml/schema/type/all'
require 'travis/yml/schema/type/any'
require 'travis/yml/schema/type/bool'
require 'travis/yml/schema/type/enum'
require 'travis/yml/schema/type/expand'
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
      extend self

      def schema
        json(expand(Def::Root.new.node))
      end

      def expand(node)
        Type::Expand.apply(node)
      end

      def json(node)
        Json::Node[node.type].new(node).schema
      end
    end
  end
end
