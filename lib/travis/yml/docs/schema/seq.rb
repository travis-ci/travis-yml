require 'travis/yml/docs/schema/node'

module Travis
  module Yml
    module Docs
      module Schema
        class Seq < Node
          include Enumerable

          attr_accessor :schema

          def initialize(parent, opts, schema = nil)
            @schema = schema
            super(parent, opts)
          end

          def each(&block)
            yield schema
          end

          def expand
            schema.expand.map do |schema|
              schema.opts[:example] ||= opts[:example]
              Seq.new(nil, opts, schema)
            end
          end

          def clone
            node = super
            node.schema = schema.clone
            node
          end
        end
      end
    end
  end
end
