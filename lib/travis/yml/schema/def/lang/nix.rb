# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Nix < Type::Lang
          register :nix

          def define
            title 'Nix'
            summary 'Nix support'
            see 'Building a Nix Project': 'https://docs.travis-ci.com/user/languages/nix/'
            matrix :nix
          end
        end
      end
    end
  end
end
