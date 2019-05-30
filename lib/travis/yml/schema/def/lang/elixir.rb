# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Elixir < Type::Lang
          register :elixir

          def define
            matrix :elixir
            matrix :otp_release
          end
        end
      end
    end
  end
end
