# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Julia < Type::Lang
          register :julia

          def define
            title 'Julia'
            summary 'Julia language support'
            see 'Building a Julia Project': 'https://docs.travis-ci.com/user/languages/julia/'
            matrix :julia
          end
        end
      end
    end
  end
end
