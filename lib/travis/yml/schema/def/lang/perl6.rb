# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Perl6 < Lang
          register :perl6

          def define
            matrix :perl6
            super
          end
        end
      end
    end
  end
end
