require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class NodeJs < Type::Lang
          register :node_js

          # # TODO Maybe this takes it a little too far ... we'd need to update
          # # this library whenever they decide to change their verion formats?
          # # This actually raises quite a few warnings on actual requests.
          # FORMAT = /^((iojs)|(iojs\-v\d+\.\d+(\.\d+)?)|(\d+(\.\d+(\.\d+)?)?)|stable|node)$/

          def define
            name :node_js, alias: %i(javascript node nodejs node-js node.js)
            # matrix :node_js, format: FORMAT
            matrix :node_js
            map :npm_args, to: :scalar
          end
        end
      end
    end
  end
end
