# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Crystal < Lang
          register :crystal

          def define
            matrix :crystal
          end
        end
      end
    end
  end
end
