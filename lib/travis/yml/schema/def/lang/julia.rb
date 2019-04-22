# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Julia < Lang
          register :julia

          def define
            matrix :julia
          end
        end
      end
    end
  end
end
