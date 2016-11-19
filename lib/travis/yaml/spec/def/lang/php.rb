require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Php < Type::Lang
          register :php

          def define
            name :php
            matrix :php
            map :composer_args, to: :scalar
          end
        end
      end
    end
  end
end
