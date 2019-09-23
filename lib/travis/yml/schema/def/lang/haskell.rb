# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Haskell < Type::Lang
          register :haskell

          def define
            title 'Haskell'
            summary 'Haskell language support'
            see 'Building a Haskell Project': 'https://docs.travis-ci.com/user/languages/haskell/'
            matrix :ghc
          end
        end
      end
    end
  end
end
