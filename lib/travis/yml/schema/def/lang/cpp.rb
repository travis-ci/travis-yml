# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Cpp < Lang
          register :cpp

          def define
            aliases :'c++'
            super
          end
        end
      end
    end
  end
end
