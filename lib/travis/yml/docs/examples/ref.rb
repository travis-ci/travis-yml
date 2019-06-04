# frozen_string_literal: true
require 'travis/yml/docs/examples/node'

module Travis
  module Yml
    module Docs
      module Examples
        class Ref < Node
          register :ref

          def examples
            []
          end

          def example
            "[ref:#{node.ref}]"
          end
        end
      end
    end
  end
end
