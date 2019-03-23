# frozen_string_literal: true
require 'travis/yaml/spec/def/jdks'
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Java < Type::Lang
          register :java

          def define
            name :java, alias: :jvm

            matrix :jdk, to: :jdks
          end
        end
      end
    end
  end
end
