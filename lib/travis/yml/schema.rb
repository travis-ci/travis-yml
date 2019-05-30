require 'travis/yml/schema/def'
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
        # node = export(node)
        # node = form(node)

        bench(:json) do
          Json::Schema.new(node).schema
        end
      end

      # def form(schema)
      #   bench(:form) do
      #     Form.apply(schema)
      #   end
      # end
      #
      # def export(schema)
      #   bench(:export) do
      #     Export.apply(schema)
      #   end
      # end

      def schema
        bench(:define) do
          Def.define
          Def.root
        end
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
