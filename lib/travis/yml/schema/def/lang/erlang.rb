# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Erlang < Lang
          register :erlang

          def define
            matrix :otp_release
          end
        end
      end
    end
  end
end
