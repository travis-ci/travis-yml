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

          def_delegators :schemas, :size, :first, :each

          def self.type
            :seq
          end

          def schemas
            @schemas ||= [Str.new(self)]
          end

          def support
            merge(super, *schemas.map(&:support))
          end
        end
      end
    end
  end
end

