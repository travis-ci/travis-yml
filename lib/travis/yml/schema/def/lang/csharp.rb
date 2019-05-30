# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Csharp < Type::Lang
          register :csharp

          def define
            matrix :dotnet
            matrix :mono
            matrix :solution
          end
        end
      end
    end
  end
end
