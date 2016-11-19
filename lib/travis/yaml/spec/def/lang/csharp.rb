require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Csharp < Type::Lang
          register :csharp

          def define
            name :csharp, alias: ['c#', 'fsharp', 'f#']
            matrix :dotnet
            matrix :mono
            matrix :solution
          end
        end
      end
    end
  end
end
