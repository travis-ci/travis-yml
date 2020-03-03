# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Erlang < Type::Lang
          register :erlang

          def define
            title 'Erlang'
            summary 'Erlang language support'
            see 'Building an Erlang Project': 'https://docs.travis-ci.com/user/languages/erlang/'
            matrix :otp_release
          end
        end
      end
    end
  end
end
