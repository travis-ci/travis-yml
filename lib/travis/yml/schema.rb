require 'travis/yml/schema/def'
require 'travis/yml/schema/dsl'
require 'travis/yml/schema/docs'
require 'travis/yml/schema/examples'
require 'travis/yml/schema/json'
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      extend self

      def json
        node = Type.transform(schema)
        Json::Node[node.type].new(node).schema
      end

      def schema
        Def::Root.new.node
      end
    end
  end
end
