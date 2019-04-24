# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Nix < Lang
          register :nix

          def define
            matrix :nix
          end
        end
      end
    end
  end
end
