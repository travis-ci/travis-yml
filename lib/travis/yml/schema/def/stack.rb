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
            summary 'Build environment stack'
            downcase
            edge
            value *NAMES
            export
            internal true
          end
        end
      end
    end
  end
end
