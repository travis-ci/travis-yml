# frozen_string_literal: true
require 'travis/yaml/spec/type/scalar'

module Travis
  module Yaml
    module Spec
      module Def
        class Sudo < Type::Scalar
          register :sudo

          def define
            cast :bool
          end
        end
      end
    end
  end
end
