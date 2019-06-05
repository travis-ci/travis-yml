# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Conditions < Type::Str
          register :conditions

          def define
            summary 'Conditions support version'
            value :v0
            value :v1
            internal
            export
          end
        end

        class Condition < Type::Str
          register :condition

          def define
            title 'If'

            description <<~str
              Include or exclude builds, stages, and jobs by specifying conditions in your
              build configuration. These are evaluated when your build is being configured.
            str

            summary 'Condition to determine whether or not a build, stage, or job should be run'

            example 'branch = master'

            see 'Conditional Builds, Stages, and Jobs' => 'https://docs.travis-ci.com/user/conditional-builds-stages-jobs/'

            export
          end
        end
      end
    end
  end
end
