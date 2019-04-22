# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class D < Lang
          register :d

          def define
            matrix :d
          end
        end
      end
    end
  end
end
