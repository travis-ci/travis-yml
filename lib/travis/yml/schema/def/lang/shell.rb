# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Shell < Type::Lang
          register :shell

          def define
            aliases *%i(bash generic minimal sh)
          end
        end
      end
    end
  end
end
