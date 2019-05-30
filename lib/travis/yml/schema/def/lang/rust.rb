# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Rust < Type::Lang
          register :rust

          def define
            matrix :rust
          end
        end
      end
    end
  end
end
