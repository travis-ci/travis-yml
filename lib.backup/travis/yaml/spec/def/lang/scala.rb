# frozen_string_literal: true
require 'travis/yaml/spec/def/jdks'
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Scala < Type::Lang
          register :scala

          def define
            name :scala
            matrix :scala
            matrix :jdk, to: :jdks
            map :sbt_args, to: :str
          end
        end
      end
    end
  end
end
