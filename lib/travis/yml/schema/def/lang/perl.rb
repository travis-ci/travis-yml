# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Perl < Lang
          register :perl

          def define
            matrix :perl
            super
          end
        end
      end
    end
  end
end
