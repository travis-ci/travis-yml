# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Compilers < Type::Seq
          register :compilers

          def define
            summary 'Compilers to set up'
            type :compiler
            export
          end
        end

        class Compiler < Type::Str
          register :compiler

          def define
            example 'gcc'
            supports :only, language: %i(c cpp)
          end
        end
      end
    end
  end
end
