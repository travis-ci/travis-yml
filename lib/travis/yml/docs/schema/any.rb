require 'travis/yml/docs/schema/node'

module Travis
  module Yml
    module Docs
      module Schema
        class Any < Node
          include Enumerable

          attr_accessor :schemas

          def each(&block)
            schemas.each(&block)
          end

          def expand
            schemas.map(&:expand).flatten.each do |schema|
              schema.opts[:example] ||= opts[:example]
            end
          end

          def clone
            node = super
            node.schemas = schemas.map(&:clone)
            node
          end
        end
      end
    end
  end
end
