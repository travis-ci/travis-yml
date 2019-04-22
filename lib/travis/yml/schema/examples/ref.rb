# frozen_string_literal: true
require 'travis/yml/schema/examples/node'

module Travis
  module Yml
    module Schema
      module Examples
        class Ref < Node
          register :ref

          def examples
            []
          end

          def example
            "[ref:#{node.ref}]"
          end

          def expand
            other = node.lookup
            other ? build(other).expand : self
          end
        end
      end
    end
  end
end
