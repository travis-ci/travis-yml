# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Sudo < Type::Any
          register :sudo

          def define
            summary 'Whether to allow sudo access'
            example 'required'
            deprecated 'The key `sudo` has no effect anymore.'

            type :bool, normal: true
            type :str

            export
          end
        end
      end
    end
  end
end
