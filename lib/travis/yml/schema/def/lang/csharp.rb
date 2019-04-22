# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Csharp < Lang
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
