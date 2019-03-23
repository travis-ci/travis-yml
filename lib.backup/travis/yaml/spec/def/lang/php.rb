# frozen_string_literal: true
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
            map :composer_args, to: :str
          end
        end
      end
    end
  end
end
