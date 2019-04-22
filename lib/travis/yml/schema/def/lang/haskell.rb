# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Haskell < Lang
          register :haskell

          def define
            matrix :ghc
          end
        end
      end
    end
  end
end
