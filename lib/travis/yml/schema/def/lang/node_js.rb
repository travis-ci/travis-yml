# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class NodeJs < Type::Lang
          register :node_js

          def define
            aliases :javascript, :js, :node

            matrix :node_js, alias: [:node]
            map :npm_args, to: :str
          end
        end
      end
    end
  end
end
