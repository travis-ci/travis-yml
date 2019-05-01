# frozen_string_literal: true
require 'travis/yml/schema/type/node'
require 'travis/yml/schema/type/opts'
require 'travis/yml/schema/type/str'

module Travis
  module Yml
    module Schema
      module Type
        class Seq < Node
          include Enumerable

          register :seq

          def_delegators :types, :size, :first, :each

          def self.type
            :seq
          end

          attr_writer :types

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
        end
      end
    end
  end
end

