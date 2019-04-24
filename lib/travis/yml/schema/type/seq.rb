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

          def types
            @types ||= []
          end

          # def support
          #   merge(super, *types.map(&:support))
          # end

          def to_h
            Dump.new(self).to_h
          end
        end
      end
    end
  end
end

