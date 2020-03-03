# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Crystal < Type::Lang
          register :crystal

          def define
            title 'Crystal'
            summary 'Crystal language support'
            see 'Building a Crystal Project': 'https://docs.travis-ci.com/user/languages/crystal/'
            matrix :crystal
          end
        end
      end
    end
  end
end
