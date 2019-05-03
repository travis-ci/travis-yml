# frozen_string_literal: true
require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class Ref < Node
          include Opts

          register :ref

          opts %i(strict)

          def self.type
            :ref
          end

          attr_reader :namespace, :id

          def ref
            "#{namespace}/#{id}"
          end

          def lookup
            node = Type.exported(namespace, id)
            node if node.is_a?(Node)
          end
        end
      end
    end
  end
end
