# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Scala < Lang
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
