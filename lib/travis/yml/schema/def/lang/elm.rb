# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Elm < Type::Lang
          register :elm

          def define
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
