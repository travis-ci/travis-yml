# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Csharp < Type::Lang
          register :csharp

          def define
            title 'C#'
            summary 'C# language support'
            see 'Building a C# Project': 'https://docs.travis-ci.com/user/languages/csharp/'
            matrix :dotnet
            matrix :mono
            matrix :solution
          end
        end
      end
    end
  end
end
