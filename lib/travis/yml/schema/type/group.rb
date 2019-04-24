# frozen_string_literal: true
require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class Group < Node
          extend Forwardable
          include Enumerable

          def_delegators :types, :each, :first

          def types=(types)
            @types = flatten(types)
          end

          def types
            @types ||= []
          end

          def flatten(types)
            types.map { |schema| schema.is_a?(self.class) ? schema.types : schema }.flatten
          end

          def to_h
            Dump.new(self).to_h
          end
        end
      end
    end
  end
end
