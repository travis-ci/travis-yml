# frozen_string_literal: true
require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class All < Node
          include Enumerable

          register :all

          def self.type
            :all
          end

          def each(&block)
            schemas.each(&block)
          end

          def schemas=(schemas)
            @schemas = flatten(schemas)
          end

          def schemas
            @schemas ||= []
          end

          def flatten(schemas)
            schemas.map { |schema| schema.is_a?(Any) ? schema.schemas : schema }.flatten
          end

          def to_h
            Dump.new(self).to_h
          end
        end
      end
    end
  end
end
