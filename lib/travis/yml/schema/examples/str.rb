# frozen_string_literal: true
require 'travis/yml/schema/examples/scalar'

module Travis
  module Yml
    module Schema
      module Examples
        class Str < Scalar
          register :str

          def examples
            ["#{example} one", "#{example} two"]
          end

          def example
            node.example || opts[:example] || 'string'
          end
        end
      end
    end
  end
end
