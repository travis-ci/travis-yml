# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Matlab < Type::Lang
          register :matlab

          def define
            title 'Matlab'
            summary 'Matlab build support'
            see 'Building a MATLAB Project': 'https://docs.travis-ci.com/user/languages/matlab/'
            matrix :matlab
          end
        end
      end
    end
  end
end
