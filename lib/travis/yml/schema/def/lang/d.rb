# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class D < Type::Lang
          register :d

          def define
            matrix :d
          end
        end
      end
    end
  end
end
