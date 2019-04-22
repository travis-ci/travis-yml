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
          end
        end
      end
    end
  end
end
