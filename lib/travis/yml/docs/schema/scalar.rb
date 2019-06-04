require 'travis/yml/docs/schema/node'

module Travis
  module Yml
    module Docs
      module Schema
        class Scalar < Node
          def type
            opts[:type]
          end
        end
      end
    end
  end
end
