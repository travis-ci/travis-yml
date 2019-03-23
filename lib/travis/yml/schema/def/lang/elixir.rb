# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Elixir < Lang
          register :elixir

          def define
            matrix :elixir
            matrix :otp_release
            super
          end
        end
      end
    end
  end
end
