# frozen_string_literal: true
require 'travis/yml/schema/examples/scalar'

module Travis
  module Yml
    module Schema
      module Examples
        class Str < Scalar
          register :str

          def examples
            enum? ? enum[0, 2] : ["#{example} one", "#{example} two"]
          end

          def example
            node.example or opts[:example] or enum? ? enum.first : 'string'
          end
        end
      end
    end
  end
end
