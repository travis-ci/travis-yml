require 'travis/yml/schema/def'
require 'travis/yml/schema/json'
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      extend self

      def json
        node = schema
        bench(:json) { Json::Schema.new(node).schema }
      end

      def schema
        bench(:define) { Type::Node.build(:root) }
      end

      def bench(key = nil)
        now = Time.now
        yield.tap do
          puts "Schema.#{(key || caller[2][/`(.*)'/] && $1).to_s.ljust(6)} took #{Time.now - now} sec"
        end
      end
    end
  end
end
