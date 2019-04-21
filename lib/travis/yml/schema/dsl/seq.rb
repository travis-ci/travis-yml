# frozen_string_literal: true
require 'travis/yml/schema/dsl/node'

module Travis
  module Yml
    module Schema
      module Dsl
        class Seq < Node
          register :seq

          def self.type
            :seq
          end

          def type(*types)
            opts = types.last.is_a?(Hash) ? types.pop : {}
            schemas = types.map { |type| Node.build(self, type, opts).node }
            node.set :schemas, schemas

            # shouldn't this happen in Map#mapped_opts?
            objs = schemas.map do |obj|
              obj = obj.lookup if obj.type == :ref
              obj.support.each do |key, opts|
                node.parent.set :keys, { node.key => { key => to_strs(opts) } } if node.parent
              end
            end
          end
        end
      end
    end
  end
end
