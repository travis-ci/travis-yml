# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Crystal < Type::Lang
          register :crystal

          def define
            matrix :crystal
          end
        end
      end
    end
  end
end
