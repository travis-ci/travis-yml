# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'

module Travis
  module Yml
    module Schema
      module Def
        class Scala < Type::Lang
          register :scala

          def define
            matrix :scala
            matrix :jdk, to: :jdks
            map :sbt_args, to: :str
          end
        end
      end
    end
  end
end
