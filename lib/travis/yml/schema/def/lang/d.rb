# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class D < Type::Lang
          register :d

          def define
            title 'D'
            summary 'D language support'
            see 'Building a D Project': 'https://docs.travis-ci.com/user/languages/d/'
            matrix :d
          end
        end
      end
    end
  end
end
