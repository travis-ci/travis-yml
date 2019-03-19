# frozen_string_literal: true
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class D < Type::Lang
          register :d

          def define
            name :d
            matrix :d
          end
        end
      end
    end
  end
end
