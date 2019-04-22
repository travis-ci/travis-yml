# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class NodeJs < Lang
          register :node_js

          def define
            aliases :javascript

            matrix :node_js, alias: [:node]
            map :npm_args, to: :str
          end
        end
      end
    end
  end
end
