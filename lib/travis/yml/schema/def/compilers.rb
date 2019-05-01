# frozen_string_literal: true
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        class Compilers < Dsl::Seq
          register :compilers

          def define
            type :compiler
            export
          end
        end

        class Compiler < Dsl::Str
          register :compiler

          def define
            supports :only, language: %i(c cpp)
          end
        end
      end
    end
  end
end
