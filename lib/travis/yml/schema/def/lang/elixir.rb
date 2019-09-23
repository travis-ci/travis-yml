# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Elixir < Type::Lang
          register :elixir

          def define
            title 'Elixir'
            summary 'Elixir language support'
            see 'Building an Elixir Project': 'https://docs.travis-ci.com/user/languages/elixir/'
            matrix :elixir
            matrix :otp_release
          end
        end
      end
    end
  end
end
