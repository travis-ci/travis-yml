# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Stages < Type::Seq
          register :stages

          def define
            summary 'Build stages definition'

            description <<~str
              Build stages group jobs, and run jobs in each stage in parallel,
              but run one stage after another sequentially.
            str

            see 'Build Stages': 'https://docs.travis-ci.com/user/build-stages/'

            normal
            type :stage

            export
          end
        end

        class Stage < Type::Map
          register :stage

          def define
            prefix :name

            map :name, to: :str, summary: 'The name of the stage', eg: 'unit tests'
            map :if,   to: :condition

            export
          end
        end
      end
    end
  end
end
