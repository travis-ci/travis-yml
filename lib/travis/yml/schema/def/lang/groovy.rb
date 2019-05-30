# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'

module Travis
  module Yml
    module Schema
      module Def
        class Groovy < Type::Lang
          register :groovy

          def define
            matrix :jdk, to: :jdks
          end
        end
      end
    end
  end
end
