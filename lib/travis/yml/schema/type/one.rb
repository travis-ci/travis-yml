# frozen_string_literal: true
require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class One < Node
          include Enumerable

          register :one

          def self.type
            :one
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
