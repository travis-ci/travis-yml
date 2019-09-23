# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Elm < Type::Lang
          register :elm

          def define
            title 'Elm'
            summary 'Elm language support'
            see 'Building an Elm Project': 'https://docs.travis-ci.com/user/languages/elm/'
            matrix :elm
            matrix :node_js

            map :elm_format, to: :str
            map :elm_test,   to: :str
          end
        end
      end
    end
  end
end
