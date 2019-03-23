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

          def schemas
            @schemas ||= []
          end
        end
      end
    end
  end
end
