# frozen_string_literal: true
require 'travis/yml/schema/examples/node'

module Travis
  module Yml
    module Schema
      module Examples
        class Ref < Node
          register :ref

          def expand
            build(node.lookup).expand
          end
        end
      end
    end
  end
end
