# frozen_string_literal: true
require 'travis/yaml/spec/type/fixed'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Compilers < Type::Seq
          register :compilers

          def define
            type :scalar
          end
        end
      end
    end
  end
end
