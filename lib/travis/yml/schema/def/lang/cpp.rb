# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Cpp < Type::Lang
          register :cpp

          def define
            aliases :'c++'
          end
        end
      end
    end
  end
end
