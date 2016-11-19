require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Perl < Type::Lang
          register :perl

          def define
            name :perl
            matrix :perl
          end
        end
      end
    end
  end
end
