# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Julia < Type::Lang
          register :julia

          def define
            matrix :julia
          end
        end
      end
    end
  end
end
