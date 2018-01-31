require 'travis/yaml/spec/def/lang/worker_stacks'
require 'travis/yaml/spec/type/fixed'

module Travis
  module Yaml
    module Spec
      module Def
        class Stack < Type::Fixed
          register :stack

          def define
            downcase

            Spec::WORKER_STACKS.each do |stack|
              value stack, edge: true
            end
          end
        end
      end
    end
  end
end
