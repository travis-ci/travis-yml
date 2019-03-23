# frozen_string_literal: true
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Smalltalk < Type::Lang
          register :smalltalk

          def define
            name :smalltalk
            matrix :smalltalk
            map :smalltalk_config, to: :seq
            map :smalltalk_edge,   to: :bool
          end
        end
      end
    end
  end
end
