# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Stack < Type::Str
          STACKS = %i(connie amethyst garnet stevonnie opal sardonyx onion cookiecat)

          register :stack

          def define
            summary 'Build environment stack'
            downcase
            edge
            value *STACKS
            export
            internal true
          end
        end
      end
    end
  end
end
