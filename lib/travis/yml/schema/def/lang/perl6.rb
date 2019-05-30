# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Perl6 < Type::Lang
          register :perl6

          def define
            matrix :perl6
          end
        end
      end
    end
  end
end
