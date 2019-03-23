# frozen_string_literal: true
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        class Compilers < Dsl::Seq
          register :compilers

          def define
            supports :only, language: %i(c cpp)
            export
          end
        end
      end
    end
  end
end
