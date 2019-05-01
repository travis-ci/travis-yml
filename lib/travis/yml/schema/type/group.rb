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
            @types = types
          end

          def types
            @types ||= []
          end

          def dup
            node = super
            node.types = node.types.map(&:dup)
            node
          end

          def to_h
            Dump.new(self).to_h
          end

          # def flatten(types)
          #   types.map { |type| type.is_a?(self.class) ? type.types : type }.flatten
          # end
        end
      end
    end
  end
end
