# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'

module Travis
  module Yml
    module Schema
      module Def
        class Java < Type::Lang
          register :java

          def define
            aliases :jvm
            matrix :jdk, to: :jdks
          end
        end
      end
    end
  end
end
