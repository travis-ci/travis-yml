require 'travis/yml/schema/def'
require 'travis/yml/schema/dsl'
require 'travis/yml/schema/docs'
require 'travis/yml/schema/examples'
require 'travis/yml/schema/export'
require 'travis/yml/schema/form'
require 'travis/yml/schema/json'
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      extend self

      def json
        node = schema
        node = export(node)
        node = form(node)
        bench(:json) { Json::Schema.new(node).schema }
      end

      def export(schema)
        bench(:export) { Export.apply(schema) }
      end

      def form(schema)
        bench(:form) { Form.apply(schema) }
      end

      def schema
        bench(:define) { Def::Root.new.node }
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
