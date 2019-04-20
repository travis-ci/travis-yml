# frozen_string_literal: true
require 'travis/yml/schema/type/node'
require 'travis/yml/schema/type/opts'

module Travis
  module Yml
    module Schema
      module Type
        class Any < Node
          include Enumerable
          include Opts

          register :any

          opts %i(detect)

          def self.type
            :any
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

          def detect=(obj)
            opts[:detect] = obj
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
