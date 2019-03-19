# frozen_string_literal: true
require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Stages < Type::Seq
          register :stages

          def define
            type :stage
          end
        end

        class Stage < Type::Map
          register :stage

          def define
            prefix :name, type: [:str]
            map :name, to: :str
            map :if,   to: :str
          end
        end
      end
    end
  end
end
