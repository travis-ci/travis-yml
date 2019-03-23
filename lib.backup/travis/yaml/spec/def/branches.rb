# frozen_string_literal: true
require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Branches < Type::Map
          register :branches

          def define
            prefix :only, type: [:str, :seq]

            map :only,   to: :seq
            map :except, to: :seq, alias: :exclude
          end
        end
      end
    end
  end
end
