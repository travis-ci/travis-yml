# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Nix < Type::Lang
          register :nix

          def define
            matrix :nix
          end
        end
      end
    end
  end
end
