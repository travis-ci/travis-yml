# frozen_string_literal: true
require 'travis/yml/schema/dsl/str'

module Travis
  module Yml
    module Schema
      module Def
        class Stack < Dsl::Str
          NAMES = %i(connie amethyst garnet stevonnie opal sardonyx onion cookiecat)

          register :stack

          def define
            downcase
            edge
            value *NAMES
            export
          end
        end
      end
    end
  end
end
