# frozen_string_literal: true
require 'travis/yml/schema/examples/node'

module Travis
  module Yml
    module Schema
      module Examples
        class Secure < Node
          register :secure

          def examples
            { secure: 'encrypted string' }
            # 'unencrypted string'
          end
        end
      end
    end
  end
end
