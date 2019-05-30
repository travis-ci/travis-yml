# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Erlang < Type::Lang
          register :erlang

          def define
            matrix :otp_release
          end
        end
      end
    end
  end
end
