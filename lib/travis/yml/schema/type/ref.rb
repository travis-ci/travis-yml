# frozen_string_literal: true
require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class Ref < Node
          register :ref

          def self.type
            :ref
          end

          attr_reader :namespace, :id

          def ref
            @ref || "#{namespace}/#{id}"
          end
        end
      end
    end
  end
end
