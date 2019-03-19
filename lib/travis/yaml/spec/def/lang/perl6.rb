# frozen_string_literal: true
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Perl6 < Type::Lang
          register :perl6

          def define
            name :perl6
            matrix :perl6
          end
        end
      end
    end
  end
end
