# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Java < Lang
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
