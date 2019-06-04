# frozen_string_literal: true
require 'travis/yml/docs/examples/node'

module Travis
  module Yml
    module Docs
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
