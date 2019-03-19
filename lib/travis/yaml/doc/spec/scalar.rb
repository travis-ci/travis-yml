# frozen_string_literal: true
require 'travis/yaml/doc/spec/node'

module Travis
  module Yaml
    module Doc
      module Spec
        class Scalar < Node
          register :scalar

          def type
            :scalar
          end
        end
      end
    end
  end
end
