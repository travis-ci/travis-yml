# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class C < Lang
          register :c

          def define
            super
          end
        end
      end
    end
  end
end

