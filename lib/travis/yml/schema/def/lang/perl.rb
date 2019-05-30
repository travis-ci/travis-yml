# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Perl < Type::Lang
          register :perl

          def define
            matrix :perl
          end
        end
      end
    end
  end
end
