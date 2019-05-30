# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Haskell < Type::Lang
          register :haskell

          def define
            matrix :ghc
          end
        end
      end
    end
  end
end
