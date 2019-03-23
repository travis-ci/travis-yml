# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Groovy < Lang
          register :groovy

          def define
            matrix :jdk, to: :jdks
            super
          end
        end
      end
    end
  end
end
